Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7V9D1rT010745
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 05:13:01 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7V9D05m016966
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 09:13:00 GMT
Date: Tue, 31 Aug 2004 10:24:13 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: banning copying of binaries (e.g. mozilla etc).
Message-ID: <20040831092413.GJ31497@lkcl.net>
References: <20040830222355.GI31497@lkcl.net> <4133B938.3070201@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4133B938.3070201@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 30, 2004 at 07:33:12PM -0400, Joshua Brindle wrote:
> Luke Kenneth Casson Leighton wrote:
> 
> >okay, got a weird issue where i am curious as to whether selinux could
> >help.
> >
> >imagine that ipt_owner has been successfully hacked up (hacked as in
> >the literal and true meaning of the word not the one the press associate
> >with it) to support program names (or as a last resort inodes) as part
> >of the checking / filtering rules.
> >
> >i.e. like fireflier's rather buggy userspace support for allowing
> >e.g. mozilla to do port 80 and port 445 but NOT any other program,
> >only done properly and in the kernel.
> >
> >now imagine that someone bypasses these rules by simply copying the
> >binary.
> >
> >in this way, they would be able to at the very least bypass "DENY"
> >rules.
> >
> >my question is, therefore, is there an easy way to ban users from
> >copying binaries, whilst still allowing users to run them?
> >
> >l.
> >
> > 
> >
> I'm not sure what you are talking about here, there is no such thing as 
> a "deny" rule in selinux, everything is denied by default.

 yes - and somewhere, there's a "allow read bin_t" rule which i
 naively thought it would be possible to remove in order to achieve
 the desired effect...

> What you want to do is simply restrict the user domains from doing the 
> things you don't want, and giving only, say, mozilla the access it 
> needs. That way if they do copy the binary to their home it'll be 
> staff_home_t and can 1) either be denied execute by staff_t or 2) be 
> allowed to execute_no_trans so that anything it does is contrained by 
> the users domain restrictions. Futher, you can give user domains access 
> to execute binaries without reading them, this should work fine but that 
> is an incomplete solution. The bottom line is you can not easily keep 
> users from getting binaries onto the system, all you can do is prevent 
> them from executing them or only let them execute them in their 
> restricted domains.

 ... but if i understand correctly, it would be better to look for
 where user_t is granted execute_no_trans (in the big user macros)
 to user_u:object_r:user_t (well it's going to be allow $1_t) and
 remove that?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
