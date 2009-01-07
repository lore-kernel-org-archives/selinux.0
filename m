Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n07CKfs0001764
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2009 07:20:41 -0500
Received: from mail-gx0-f17.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n07CKZIL012828
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2009 12:20:40 GMT
Received: by gxk10 with SMTP id 10so322378gxk.18
        for <selinux@tycho.nsa.gov>; Wed, 07 Jan 2009 04:20:35 -0800 (PST)
Subject: Re: Postfix with domain keys
From: Martin Spinassi <martins.listz@gmail.com>
Reply-To: martins.listz@gmail.com
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200901070924.27508.russell@coker.com.au>
References: <1231243582.2946.106.camel@kr0sty.livra.local>
	 <200901070924.27508.russell@coker.com.au>
Content-Type: text/plain; charset=utf-8
Date: Wed, 07 Jan 2009 10:33:29 -0200
Message-Id: <1231331609.2946.152.camel@kr0sty.livra.local>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-01-07 at 09:24 +1100, Russell Coker wrote:
> On Tuesday 06 January 2009 23:06, Martin Spinassi <martins.listz@gmail.com> 
> wrote:
> > We're trying to add domain keys to a postfix server, but it can't open
> > ports used by dkim to sign the mail. Here is some output of audit.log:
> 
> What do you mean?  How are you using DKIM signatures?
> 
> I am using DKIM on my Postfix server, for the Debian SE Linux policy I have a 
> domain dkim_t used for the dkim-filter program (the Milter that is used for 
> signing and checking signatures - known outside Debian as dkim-milter).
> 
> Ancient versions of Postfix used to require a configuration where the mail was 
> forwarded to a different port where a daemon then forwarded it back - it was 
> really ugly in every possible way and didn't scale.  Among other things it 
> caused a proliferation of Received lines which sometimes triggered mail loop 
> detection and exposed details of the configuration to the world when sending 
> mail.
> 
> http://www.postfix.org/MILTER_README.html
> 
> Using a Milter is the best way to do it on a recent version of Postfix.  It 
> requires Postfix version 2.3 or newer (which means the vast majority of 
> Postfix servers are new enough).
> 
> > I've allready added the port to the postfix_master_t domain with:
> > # semanage port -a -t postfix_master_t -p tcp 10026
> 
> Generally the best thing to do in such situations is to examine the context 
> used for a similar port, the command "semanage port -l|grep 25" shows that 
> smtp_port_t is used.  While I don't recommend doing what you are doing, using 
> the type smtp_port_t is probably going to give a better result than any other 
> pre-existing type.
> 
> > It's a RHEL 5.2 and kernel 2.6.18-92.1.22.el5.
> 
> I have some CentOS 5.2 servers running Postfix with a milter for DKIM (as part 
> of the work required to provide the real service).  The milter in question is 
> a proprietary system to prevent Phishing email (you can contact me off-list 
> if you want to participate in the beta program).
> 
> But I'm sure that dkim-milter would also work well on CentOS 5.2 and RHEL 5.2 
> with Postfix.

Thanks for the advice Rusell.

I've finally done it with dkproxy ( http://dkimproxy.sourceforge.net/ ).
Yes, the mail require forward to localhost, sign and then back to queue.
I'll read about milter, may be it worth the effort to change it ;)

About selinux, I solved it (not very gracefully):

# semanage port -d -t postfix_master_t -p tcp 10026

and then added it to smtp_port_t

# semanage port -a -t smtp_port_t -p tcp 10026

Stephen Smalley gave me some hints to make a dkim type, and make it a
little securer. I'll give it a shot, but I need to understand a little
more about selinux before trying it.


Thanks again for the help.


Cheers.


Martín




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
