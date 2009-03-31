Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2V37IYN027131
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 23:07:18 -0400
Received: from smtp103.prem.mail.sp1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n2V37HSm028460
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 03:07:17 GMT
Message-ID: <49D188D6.6020107@schaufler-ca.com>
Date: Mon, 30 Mar 2009 20:07:02 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Jarrett Lu <Jarrett.Lu@sun.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted
 to IETF	website
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM> <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM> <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com> <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com> <1238434634.2484.90.camel@localhost.localdomain> <49D10FC1.3000103@sun.com>
In-Reply-To: <49D10FC1.3000103@sun.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jarrett Lu wrote:
> ...
> As Casey and others pointed out, a lot more information about a
> communicating peer is needed in order to be able to translate a label
> and other security attributes. People have tried this in 90's.
> Apparently the solution is no longer in use today.

You're giving us more credit than we're due. No, the problem was never
solved. Oh, we had a few "interoperability rings", where we got together
and tried talking CIPSO and SAMP to each other, but it was sort of like
going to a SciFi convention and striking up conversations in Klingon.
I believe that DEC claimed they could talk to SUN using SAMP and HP
could talk to SGI in CIPSO, and everyone could banter in their own
version of NFS, but there was no money behind it, and interoperability
was never achieved even at the low levels.

> Maybe we can do something better 15 years later. The first step is to
> figure out how much information is needed and then look into how to
> get this info across securely. GSS_SEC may be able to help us. To make
> NFSv4 work, only TCP is needed. So peer information is needed per
> session vs. per packet, I believe. Evidently, there is more work to do
> in figuring this all out.

Not to throw a puppy in the gears, but sophisticated handshaking and
negotiation protocols are not the answer. We had TSIG session management
for doing that and it is just not enough. How would you negotiate the
differences between two SELinux policies?

>
> A process related question: Should we move the "design" related
> discussion to a smaller alias? I assume most people don't care about
> the details and prefer not see this in their email inbox. I set up a
> mail alias, doi-discuss@opensolaris.org, a few months ago for a
> similar discussion. If people think that's a good way to go, I can
> provide more info.

I would be delighted to see the discussion stay here. I would expect
a smaller group to end up with a rehash of one of the TSIX protocols
and a chip on their shoulders to make it go because of the work that
had gone into it. The problem is not one of communication, it's one
of getting the information communicated to make sense. Look at CIFS
and NFSv4 ACLs. That is the level of effort you have to invest to
solve the problem for a pair of different security schemes. True,
the more similar the schemes the more likely the results will make
sense, but even two Smack systems with different rule sets, or
two TOMOYO boxes with different profiles are beyond what you can fit
in a configuration database.

NFSv4 with labels will properly only ever support servers and clients
with identical label configurations, and with that the DOI becomes
meaningless. If you want to support labels improperly you have a
much better chance of success, but a tougher row to hoe with the
standards bodies. This is hard, and we've been working since the 80's
on it, looking for someone smarter than us to propose a solution.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
