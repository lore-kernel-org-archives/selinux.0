Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6PCtr8a021245
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 08:55:53 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6PCtpte007343
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 12:55:52 GMT
Message-ID: <4E2D67D7.3070402@tresys.com>
Date: Mon, 25 Jul 2011 08:55:51 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: <russell@coker.com.au>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: apol and active modules
References: <201107242126.19144.russell@coker.com.au> <4E2D6356.1070007@tresys.com> <201107252248.55086.russell@coker.com.au>
In-Reply-To: <201107252248.55086.russell@coker.com.au>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/25/11 08:48, Russell Coker wrote:
> On Mon, 25 Jul 2011, "Christopher J. PeBenito"<cpebenito@tresys.com>  wrote:
>> On 07/24/11 07:26, Russell Coker wrote:
>>> Why can't apol (at least version 3.3.6.ds) parse the files in
>>> /etc/selinux/$SELINUXTYPE/modules/active/modules?  Is this considered a
>>> bug or a wontfix thing?
>>
>> Can you be more specific about your usage?  There shouldn't be a problem
>> looking at those, since they're just a copy of what you install via
>> semodule -i/-b.
>
> # diff /usr/share/selinux/default/base.pp \
> /etc/selinux/default/modules/active/base.pp
> Binary files /usr/share/selinux/default/base.pp and
> /etc/selinux/default/modules/active/base.pp differ
>
> The files are not just a copy.

It sounds like there might be some corruption.  I did the same diff on 
my system and came up with no changes.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
