Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6R42O7Y000329
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 00:02:24 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ole Kliemann <ole@plastictree.net>, selinux@tycho.nsa.gov
Subject: Re: Information about XSELinux
Date: Fri, 27 Jul 2012 14:02:15 +1000
References: <20120716161006.GA14824@telvanni> <50081541.3040909@redhat.com> <20120719144405.GB19890@telvanni>
In-Reply-To: <20120719144405.GB19890@telvanni>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201207271402.15812.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Jul 2012, Ole Kliemann <ole@plastictree.net> wrote:
> I'm not exactly sure how MLS works, but I'd intuitively would 
> say, my approach is more MLS-like because change of privileges 
> only goes in one direction. Privileges are only dropped, never 
> gained. (Mainuser drops to subuser, subuser never elevates back 
> to mainuser or any other subuser.)
> 
> I started working on a policy for X using TE. Do you think, what 
> I want could be better expressed in MLS?

MLS is about sensitivity levels of data with a theoretical model of allowing 
processes with a high clearance to read data of a low sensitivity so data can 
migratre to a higher classification.  While that could be used for standard X 
access control it probably isn't what most people want.  What you probably 
want is for example to have mozilla_t not be able to mess with X apps running 
as user_t or unconfined_t.

In terms of MLS and X access controls I guess you could have different ssh 
servers configured to have different levels and then run "ssh -X" (or "ssh -Y" 
- how does that interact with X access controls) to each of the servers from a 
different level and therefore not allow processes from server A to mess with 
processes from server B via X on your workstation.

On Tue, 24 Jul 2012, Ole Kliemann <ole@plastictree.net> wrote:
> I'm running X in enforcing too now with a simple setup. There is 
> a domain for every job (browser, mail, ...). These domains can't 
> access each other. The WM has access to all of them. Copy/paste 
> works like a charm with every domain having its own cutbuffer and 
> a small script called from the WM to copy the cutbuffer to other 
> domains.
> 
> Of course I had to allow some things in X that I do not fully 
> understand. But there is definitely no more sending synthetic 
> input events to foreign windows and no more keylogging.

Could you blog about all the details?

I've wanted to get X access control in Debian for a while.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
