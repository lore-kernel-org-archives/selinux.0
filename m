Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8LG4weQ005343
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 12:04:58 -0400
Received: from web36610.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8LG4uo4007050
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 16:04:57 GMT
Date: Fri, 21 Sep 2007 09:04:37 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 00/22] Introduce credential record
To: David Howells <dhowells@redhat.com>, casey@schaufler-ca.com
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <9072.1190389216@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <533105.53764.qm@web36610.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> > > One thing I'm not certain about is how this should interact with /proc,
> > > which can display some of the stuff in the cred struct.  I think it may
> be
> > > necessary to have a real cred pointer and an effective cred pointer, with
> > > the contents of /proc coming from the real, but the effective governing
> > > what actually goes on.
> > 
> > I think you want the effective values to show up in /proc.
> 
> Perhaps - but bear in mind that in the override case they weren't set by the
> process itself.

They are nonetheless in effect and (heaven forbid) should they be
abused you don't want to hide the facts from concerned observers.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
