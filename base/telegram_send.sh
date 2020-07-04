#!/bin/bash
#
# Copyright (C) 2020 SebaUbuntu's HomeBot
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

get_arguments() {
	while [ "${#}" -gt 0 ]; do
		case "${1}" in
			--markdown )
				echo true
				;;
		esac
		shift
	done
}

# Arguments: <chatid> <message_text> <message_id (for reply, optional)>
tg_send_message() {
	local USE_MARKDOWN=$(get_arguments "$@")
	if [ "$3" != "" ]; then
		curl -s -S -X POST "$TG_API_URL/sendMessage" -d chat_id="$1" -d text="$2" -d reply_to_message_id="$3" -d disable_web_page_preview="true" $(if [ "$USE_MARKDOWN" = true ]; then printf -- '-d parse_mode=Markdown'; fi) | jq .
	else
		curl -s -S -X POST "$TG_API_URL/sendMessage" -d chat_id="$1" -d text="$2" -d disable_web_page_preview="true" $(if [ "$USE_MARKDOWN" = true ]; then printf -- '-d parse_mode=Markdown'; fi) | jq .
	fi
}

# Arguments: <chatid> <file_path> <message_id (for reply, optional)>
tg_send_photo() {
	if [ "$3" != "" ]; then
		curl -s -S "$TG_API_URL/sendPhoto?chat_id=${1}&reply_to_message_id=${3}" -F photo=@"$2" | jq .
	else
		curl -s -S "$TG_API_URL/sendPhoto?chat_id=${1}" -F photo=@"$2" | jq .
	fi
}

# Arguments: <chatid> <file_path> <message_id (for reply, optional)>
tg_send_audio() {
	if [ "$3" != "" ]; then
		curl -s -S "$TG_API_URL/sendAudio?chat_id=${1}&reply_to_message_id=${3}" -F audio=@"$2" | jq .
	else
		curl -s -S "$TG_API_URL/sendAudio?chat_id=${1}" -F audio=@"$2" | jq .
	fi
}

# Arguments: <chatid> <file_path> <message_id (for reply, optional)>
tg_send_document() {
	if [ "$3" != "" ]; then
		curl -s -S "$TG_API_URL/sendDocument?chat_id=${1}&reply_to_message_id=${3}" -F document=@"$2" | jq .
	else
		curl -s -S "$TG_API_URL/sendDocument?chat_id=${1}" -F document=@"$2" | jq .
	fi
}

# Arguments: <chatid> <file_path> <message_id (for reply, optional)>
tg_send_video() {
	if [ "$3" != "" ]; then
		curl -s -S "$TG_API_URL/sendVideo?chat_id=${1}&reply_to_message_id=${3}" -F video=@"$2" | jq .
	else
		curl -s -S "$TG_API_URL/sendVideo?chat_id=${1}" -F video=@"$2" | jq .
	fi
}

# Arguments: <chatid> <file_path> <message_id (for reply, optional)>
tg_send_animation() {
	if [ "$3" != "" ]; then
		curl -s -S "$TG_API_URL/sendAnimation?chat_id=${1}&reply_to_message_id=${3}" -F animation=@"$2" | jq .
	else
		curl -s -S "$TG_API_URL/sendAnimation?chat_id=${1}" -F animation=@"$2" | jq .
	fi
}

# Arguments: <chatid> <message_id> <message_text>
tg_edit_message_text() {
	local USE_MARKDOWN=$(get_arguments "$@")
	curl -s -S -X POST "$TG_API_URL/editMessageText" -d chat_id="$1" -d message_id="$2" -d text="$3" -d disable_web_page_preview="true" $(if [ "$USE_MARKDOWN" = true ]; then printf -- '-d parse_mode=Markdown'; fi) | jq .
}

# Arguments: <chatid> <message_id> <message_text>
tg_edit_message_caption() {
	local USE_MARKDOWN=$(get_arguments "$@")
	curl -s -S -X POST "$TG_API_URL/editMessageMedia" -d chat_id="$1" -d message_id="$2" -d text="$3" $(if [ "$USE_MARKDOWN" = true ]; then printf -- '-d parse_mode=Markdown'; fi) | jq .
}

# Arguments: <chatid> <emoji> <message_id (for reply, optional)>
tg_send_dice() {
	if [ "$3" != "" ]; then
		curl -s -S -X POST "$TG_API_URL/sendDice" -d chat_id="$1" -d emoji="$2" -d reply_to_message_id="$3" | jq .
	else
		curl -s -S -X POST "$TG_API_URL/sendDice" -d chat_id="$1" -d emoji="$2" | jq .
	fi
}
