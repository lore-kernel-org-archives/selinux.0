Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1SDZkDo024195
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2005 08:35:46 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1SDU3Yx000819
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2005 13:30:03 GMT
Subject: Re: Mozilla content handlers
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <422319D1.8050100@redhat.com>
References: <1109544507.23339.24.camel@cobra.ivg2.net>
	 <422319D1.8050100@redhat.com>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 08:36:08 -0500
Message-Id: <1109597769.2432.10.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-02-28 at 08:17 -0500, Daniel J Walsh wrote:
>Ivan Gyurdiev wrote:
>
>>So, I've been wondering how exactly mozilla handles
>>the ability to invoke content handlers under SElinux.
>>Now I see that it doesn't handle it at all...
>>trying to open a word document in open office fails with 
>>a large number of denials. It can transition to $1_mplayer_t, 
>>and that's about it. How should this be corrected?
>>
>>  
>>
>I don't think we can handle this well.  This should be brought up for 
>discussion on the main list.
>
>Basically you need a transition to user_t which will destroy the 
>security of mozilla, I think.  Once
>you start to allow mozilla to exec random apps like ooffice, you expand 
>the security realm into full
>userspace.

Speaking of which, I have a related question.
What is the general direction into which policy is heading re: desktop
programs (like inkscape, lame, open office, totem, xine). Will they
remain in user_t, like you say, or will policies be written for all
those programs, and will they be constrained to minimum privilege as
well?

(Thread cc-ed to NSA-list)

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
