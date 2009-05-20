Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4KCuiXd011391
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 08:56:44 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4KCur5d000890
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 12:56:53 GMT
Message-ID: <4A13FE02.5050701@redhat.com>
Date: Wed, 20 May 2009 08:56:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: hechao55429 <hechao55429@126.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: selinux policy  for gedit
References: <12675062.1102781242816752701.JavaMail.coremail@bj126app52.126.com>
In-Reply-To: <12675062.1102781242816752701.JavaMail.coremail@bj126app52.126.com>
Content-Type: text/plain; charset=x-gbk; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/20/2009 06:52 AM, hechao55429 wrote:
> hello everyone :
>    I'm learning the selinux policy.I wrote a selinux policy module for gedit a few days ago .When I loaded the policy into the target policy runing on the fedora 10 and ran the gedit application , I encountered the following problems:
>
> [root@localhost ~]# gedit
> (gedit:2697): Pango-CRITICAL **: No fonts found:
> This probably means that the fontconfig
> library is not correctly configured. You may need to
> edit the fonts.conf configuration file. More information
> about fontconfig can be found in the fontconfig(3) manual
> page and on http://fontconfig.org
> (gedit:2697): Pango-WARNING **: failed to find shape engine, expect ugly output. engine-type='PangoRenderFc', script='han'
> (gedit:2697): Pango-WARNING **: failed to find shape engine, expect ugly output. engine-type='PangoRenderFc', script='latin'
> (gedit:2697): Pango-WARNING **: failed to find shape engine, expect ugly output. engine-type='PangoRenderFc', script='common'
> (gedit:2697): Pango-CRITICAL **: _pango_engine_shape_covers: assertion `PANGO_IS_FONT (font)' failed
> [root@localhost ~]#
> Here is a screenshot:
>
>
>
You need to give gedit the ability to read fonts.

miscfiles_read_fonts(gedit_t)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
