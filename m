Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UNXErT008691
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 19:33:14 -0400 (EDT)
Received: from smtp.gentoo.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UNWQAE028364
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 23:32:26 GMT
Message-ID: <4133B938.3070201@tresys.com>
Date: Mon, 30 Aug 2004 19:33:12 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: banning copying of binaries (e.g. mozilla etc).
References: <20040830222355.GI31497@lkcl.net>
In-Reply-To: <20040830222355.GI31497@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>okay, got a weird issue where i am curious as to whether selinux could
>help.
>
>imagine that ipt_owner has been successfully hacked up (hacked as in
>the literal and true meaning of the word not the one the press associate
>with it) to support program names (or as a last resort inodes) as part
>of the checking / filtering rules.
>
>i.e. like fireflier's rather buggy userspace support for allowing
>e.g. mozilla to do port 80 and port 445 but NOT any other program,
>only done properly and in the kernel.
>
>now imagine that someone bypasses these rules by simply copying the
>binary.
>
>in this way, they would be able to at the very least bypass "DENY"
>rules.
>
>my question is, therefore, is there an easy way to ban users from
>copying binaries, whilst still allowing users to run them?
>
>l.
>
>  
>
I'm not sure what you are talking about here, there is no such thing as 
a "deny" rule in selinux, everything is denied by default.
What you want to do is simply restrict the user domains from doing the 
things you don't want, and giving only, say, mozilla the access it 
needs. That way if they do copy the binary to their home it'll be 
staff_home_t and can 1) either be denied execute by staff_t or 2) be 
allowed to execute_no_trans so that anything it does is contrained by 
the users domain restrictions. Futher, you can give user domains access 
to execute binaries without reading them, this should work fine but that 
is an incomplete solution. The bottom line is you can not easily keep 
users from getting binaries onto the system, all you can do is prevent 
them from executing them or only let them execute them in their 
restricted domains.

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
