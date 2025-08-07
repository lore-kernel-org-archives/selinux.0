Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAC3610D
	for <selinux@vger.kernel.org>; Thu,  7 Aug 2025 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546877; cv=none; b=F1FDj2gN8oqdAXIyx4Uc7smJoLULHgAXfSdaUdwLk5YjM2Ctf+Grq+kDmbsieUlBU/bo5dzO86ETl9RjNczPIbir+ovAmll3cediBr3+SunK8vQP+7T2eQc7pl7wCub/sLW5lIncAc7KI1L0iFjsM3948kgH/DSooBJLqgLbf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546877; c=relaxed/simple;
	bh=bwZi8MaeF4Hw4C+CkfAI0K70KAl5Uxvlxj3suZMNv88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlDTkGYwYh6Y7UT7My6+ZVhQAQiIHw9BzO7bhOKDDqjuiL0M8mvMEyZhzrKrbqqm1cH7roFiKiKPn4x2ttWSvLB1pUbqXXThr5iNkU6rFeIcYuuz5WmBxfeIiNtQ/kMgONivGEAcZTlh/Rx2NUa0OWBeh3d1Mudt1N1QF9Kpgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ON+NPbOk; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ON+NPbOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=QAHX9XKCI8/QuUc1Kq5ajxvEpdhaY/X6pQypKla7Gak=;
	b=ON+NPbOkQDwLkNvNQggNCOTxMCMWigWw2mSqpWpw3VrFZ1sfOe98ZftkSGjUVj
	qGxxPNXLxgpb0Gu2uiVlIMNzFK2JzL3QCUAyhmrnszKvJ91av1peeuWO6+nVIlBT
	yXxrCU1oKpXQ21hdh4jmnXKlQuzzcs6HxtEsHOdHpy9U8=
Received: from [192.168.3.49] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnN9GvQpRo9OAoAQ--.35494S2;
	Thu, 07 Aug 2025 14:07:44 +0800 (CST)
Message-ID: <205d64c9-98c6-4ab7-a74a-5de5f797105f@163.com>
Date: Thu, 7 Aug 2025 14:07:50 +0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libsemanage: get_home_dirs: cleanup parsing of values
 from conf files
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
References: <20250730181503.991208-2-nvraxn@gmail.com>
 <CAEjxPJ4UKshtRGPyEKwkfTS-D5uc9thFNovC2_--kdV-Y3gDbg@mail.gmail.com>
From: Fei Shao <robinshao007@163.com>
In-Reply-To: <CAEjxPJ4UKshtRGPyEKwkfTS-D5uc9thFNovC2_--kdV-Y3gDbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN9GvQpRo9OAoAQ--.35494S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyrZrW8CF4rJw45Gr13XFb_yoWrGF18pr
	Z5WF15GFW7XFySvrsIva1DXa4rXwn2gr1UKwn7ta48trWDAFn3Wr43Cw4IkFyakF12g3W2
	y3yFqrnxuw1qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRFD7fUUUUU=
X-CM-SenderInfo: purex0pvkd0iiqx6il2tof0z/1tbiOh+iC2iUQpUDlgAAsy



on  2025-08-02 1:46, Stephen Smalley wrote:
> On Wed, Jul 30, 2025 at 2:15 PM Rahul Sandhu <nvraxn@gmail.com> wrote:
>> atoi (3) is... bugprone.  It's virtually impossible to differentiate an
>> invalid value (e.g. the string "foo") from a valid value such as "0" as
>> 0 is returned on error!  From the manual page:
>>
>>>        except that atoi() does not detect errors.
>>> RETURN VALUE
>>>        The converted value or 0 on error.
>> In the case of get_home_dirs, atoi is downright wrong.  We are parsing
>> UID_MIN, UID_MAX, and LU_UIDNUMBER, which all have a numerical value,
>> without any validation that what we are parsing is actually a number.
>> This is especially problematic as that means that in the case of an
>> invalid value (e.g. UID_MIN=foo), UID_MIN is incorrectly parsed as 0.
>>
>> Instead, use strtoul (3) to parse these values.  If parsing fails, such
>> as in the case where UID_MIN=foo, warn that parsing failed, and use the
>> default values for each key as specified by the manual page.
>>
>> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>> ---
>>   libsemanage/src/genhomedircon.c | 41 ++++++++++++++++++++++++++++-----
>>   1 file changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
>> index 8782e2cb..a7b44d8d 100644
>> --- a/libsemanage/src/genhomedircon.c
>> +++ b/libsemanage/src/genhomedircon.c
>> @@ -354,24 +354,53 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
>>
>>          path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL);
>>          if (path && *path) {
>> -               temp = atoi(path);
>> -               minuid = temp;
>> -               minuid_set = 1;
>> +               char *endptr;
>> +               const unsigned long val = strtoul(path, &endptr, 0);
>> +               if (endptr != path && *endptr == '\0') {
>> +                       minuid = (uid_t)val;
>> +                       minuid_set = 1;
>> +               } else {
>> +                       /* we were provided an invalid value, use defaults.  */
>> +                       WARN(s->h_semanage,
>> +                            "Conversion failed for key UID_MIN, is its value a number?"
>> +                            "  Falling back to default value of `1000`.");
>> +                       minuid = 1000;
> Here and below, it would be nice if we could use a #define, either a
> pre-existing one or one of our own, and avoid manual duplication of
> the value/string.
At top of get_home_dirs, the minuid is set to 500 default, Should the 
value be reset to 500 by default here?
>> +                       minuid_set = 1;
In both the if and else branches,|minuid_set|is set to 1 — could this be 
moved outside the conditional blocks and implemented with just a single 
line of code?
>> +               }
>>          }
>>          free(path);
>>          path = NULL;
>>
>>          path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL);
>>          if (path && *path) {
>> -               temp = atoi(path);
>> -               maxuid = temp;
>> +               char *endptr;
>> +               const unsigned long val = strtoul(path, &endptr, 0);
>> +               if (endptr != path && *endptr == '\0') {
>> +                       maxuid = (uid_t)val;
>> +               } else {
>> +                       /* we were provided an invalid value, use defaults.  */
>> +                       WARN(s->h_semanage,
>> +                            "Conversion failed for key UID_MAX, is its value a number?"
>> +                            "  Falling back to default value of `6000`.");
6000 or 60000?
> Note the inconsistency here, which would be avoided by the approach
> suggested above.
>
>> +                       maxuid = 60000;
>> +               }
>>          }
>>          free(path);
>>          path = NULL;
>>
>>          path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
>>          if (path && *path) {
>> -               temp = atoi(path);
>> +               char *endptr;
>> +               const unsigned long val = strtoul(path, &endptr, 0);
>> +               if (endptr != path && *endptr == '\0') {
>> +                       temp = (uid_t)val;
>> +               } else {
>> +                       /* we were provided an invalid value, use defaults.  */
>> +                       WARN(s->h_semanage,
>> +                            "Conversion failed for key LU_UIDNUMBER, is its value a number?"
>> +                            "  Falling back to default value of `500`.");
>> +                       temp = 500;
> Ditto.
>
>> +               }
>>                  if (!minuid_set || temp < minuid) {
>>                          minuid = temp;
>>                          minuid_set = 1;
>> --
>> 2.50.1
>>
>>

