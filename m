Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4UHprbW022680
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 13:51:56 -0400
Received: by mail-lf0-f68.google.com with SMTP id q24so9478604lfb.1
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 10:51:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496152342.2164.5.camel@tycho.nsa.gov>
References: <149581433492.13821.14132385005185399089.stgit@sifl>
 <1496152342.2164.5.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 May 2017 13:51:38 -0400
Message-ID: <CAHC9VhQLO-91w=UPKMFNpo0=HrUbzatLq+ohREqNytmfawmgSw@mail.gmail.com>
Subject: Re: [RFC PATCH] tools: add perltidy to the syntax checker/fixer
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 30, 2017 at 9:52 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2017-05-26 at 11:58 -0400, Paul Moore wrote:
>> From: Paul Moore <paul@paul-moore.com>
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  tools/check-syntax |   86 ++++++++++++++++++++++++++++++++++++++++
>> ------------
>>  1 file changed, 66 insertions(+), 20 deletions(-)

...

>>  #
>> -# Fix the formatting on a C source/header file
>> +# Fix the formatting on a file
>>  #
>>  # Arguments:
>> -#     1    File to fix
>> +#     1    Language
>> +#     2    File to check
>>  #
>> -function tool_c_style_fix() {
>> -     [[ -z "$1" || ! -r "$1" ]] && return
>> +function style_fix() {
>> +     [[ -z "$1" ]] && return
>> +     [[ -z "$2" || ! -w "$2" ]] && return
>>
>> -     tmp="$(mktemp --tmpdir=$(dirname "$1"))"
>> -     tool_c_style "$1" > "$tmp"
>> -     mv "$tmp" "$1"
>> +     tmp="$(mktemp --tmpdir=$(dirname "$2"))"
>> +     case "$1" in
>> +     c|C)
>> +             tool_c_style "$2" > "$tmp"
>> +             ;;
>> +     perl|Perl)
>> +             tool_perl_style "$2" > "$tmp"
>> +             ;;
>> +     esac
>> +     mv "$tmp" "$2"
>
> This approach doesn't preserve mode or other attributes on the file,
> and therefore leaves the perl scripts non-executable after running
> ./tools/check_syntax -f.

Yes, good point.  I'll replace that final mv command with the following:

  cat "$tmp" > "$2"
  rm "$tmp"

-- 
paul moore
www.paul-moore.com
