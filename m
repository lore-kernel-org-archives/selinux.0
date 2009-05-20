Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4KDXEct017643
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 09:33:14 -0400
Received: from mail-gx0-f180.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4KDXN5d018143
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 13:33:23 GMT
Received: by gxk28 with SMTP id 28so602609gxk.18
        for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 06:33:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A13FE02.5050701@redhat.com>
References: <12675062.1102781242816752701.JavaMail.coremail@bj126app52.126.com>
	 <4A13FE02.5050701@redhat.com>
Date: Wed, 20 May 2009 06:33:13 -0700
Message-ID: <dd18b0c30905200633j772cd1e4t59673e671359e201@mail.gmail.com>
Subject: Re: selinux policy for gedit
From: Justin Mattock <justinmattock@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: hechao55429 <hechao55429@126.com>, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2009/5/20 Daniel J Walsh <dwalsh@redhat.com>:
> On 05/20/2009 06:52 AM, hechao55429 wrote:
>>
>> hello everyone :
>>   I'm learning the selinux policy.I wrote a selinux policy module for
>> gedit a few days ago .When I loaded the policy into the target policy runing
>> on the fedora 10 and ran the gedit application , I encountered the following
>> problems:
>>
>> [root@localhost ~]# gedit
>> (gedit:2697): Pango-CRITICAL **: No fonts found:
>> This probably means that the fontconfig
>> library is not correctly configured. You may need to
>> edit the fonts.conf configuration file. More information
>> about fontconfig can be found in the fontconfig(3) manual
>> page and on http://fontconfig.org
>> (gedit:2697): Pango-WARNING **: failed to find shape engine, expect ugly
>> output. engine-type='PangoRenderFc', script='han'
>> (gedit:2697): Pango-WARNING **: failed to find shape engine, expect ugly
>> output. engine-type='PangoRenderFc', script='latin'
>> (gedit:2697): Pango-WARNING **: failed to find shape engine, expect ugly
>> output. engine-type='PangoRenderFc', script='common'
>> (gedit:2697): Pango-CRITICAL **: _pango_engine_shape_covers: assertion
>> `PANGO_IS_FONT (font)' failed
>> [root@localhost ~]#
>> Here is a screenshot:
>>
>>
>>
> You need to give gedit the ability to read fonts.
>
> miscfiles_read_fonts(gedit_t)
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>

if you look in /etc/fonts/fonts.conf
you should see:

<!-- Font directory list -->

        <dir>/usr/share/fonts</dir>

        <dir>~/.fonts</dir>

you should have something in
/usr/share/fonts/*
(or wherever there located on your system)

-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
