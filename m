Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 22:11:48 +0200
Cc: Howard Holm <hdholm@epoch.ncsc.mil>, Tom <tom@lemuria.org>,
        <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204121514350.21729-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204121514350.21729-100000@raven>
MIME-Version: 1.0
Message-Id: <20020412201148.E8D262870D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 21:17, Stephen Smalley wrote:
> On Fri, 12 Apr 2002, Westerman, Mark wrote:
> > Could you think about placing the policy sources
> > into the /usr/local/selinux Directory
> >
> > For new version of selinux the install could look and
> > see if there is a /usr/local/selinux/policy and setfiles
> > if the directories are present the install will populate then
> > with the example policy. If the directories are present just
> > overwrite the /usr/local/selinux/share/doc/example files.
>
> This is fine with me.  It merely involves adding a new target to the
> policy and setfiles Makefiles to install the sources for the
> configurations and then adjusting the README and quickinstall target to
> include that step.

This is no benefit for me, and may actually just add work as I have to remove 
your code.

To do this in Debian packages I have to do this all myself, and I expect that 
the same applies to RPMs.  So essentially if you do the same thing in the 
upstream you'll possibly benefit Slackware users, but no-one else.

Also we need more than this.  We need code to detect changes in the sample 
policy and to offer the users conveniant ways of tracking them.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
