Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5N474qf011034
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 00:07:04 -0400
Received: from web36605.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5N47285009659
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 04:07:03 GMT
Date: Fri, 22 Jun 2007 21:07:02 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        James Carter <jwcart2@epoch.ncsc.mil>,
        Chris Vance <Christopher.Vance@sparta.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>, nfsv4@linux-nfs.org,
        Trond Myklebust <trond.myklebust@fys.uio.no>, neilb@suse.de
In-Reply-To: <Line.LNX.4.64.0706222014400.9045@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <533442.35268.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- James Morris <jmorris@namei.org> wrote:

> On Fri, 22 Jun 2007, Casey Schaufler wrote:
> 
> > Somewhere between 2000 and 2002 (it's all a blur to me now) SGI
> > made the OB1 project available on oss.sgi.com.
> 
> I remember that :-)
> 
> > Included in this
> > project was the source code for an extended attribute protocol
> > to sit beside NFSv3. I have attached the code as a worked example
> > of how one can go about implementing linux style* extended attributes
> > in a distributed environment. This scheme does not address all of
> > your requirements, it only addresses transport and storage, it does
> > not address authentication or validation.
> 
> Interesting -- I gather you ran this over labeled networking?

You can, and we did, but we also ran it over unlabeled networks.
It is a protocol that handles extended attributes, which Irix
(vanilla Unix) used for ACLs and capabilities. The protocol is
agnostic to the use to which the attributes are put and to their
content, like any good file system. It doesn't do crypo. It does
not do attribute validation or translation, but neither do other
file systems.

I have ideas on those issues, but gotta run. I'll see about
coming back to it.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
