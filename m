Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0GH8Nvl005640
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2008 12:08:23 -0500
Received: from web36604.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m0GH8MVY019553
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2008 17:08:22 GMT
Date: Wed, 16 Jan 2008 09:08:16 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 08/26] Add a secctx_to_secid() LSM hook to go along with the existing
To: Paul Moore <paul.moore@hp.com>, James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, sds@tycho.nsa.gov,
        casey@schaufler-ca.com, Trond.Myklebust@netapp.com, npiggin@suse.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <200801160841.46633.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <229068.55387.qm@web36604.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:

> On Tuesday 15 January 2008 8:05:27 pm James Morris wrote:
> > On Tue, 15 Jan 2008, David Howells wrote:
> > > secid_to_secctx() LSM hook.  This patch also includes the SELinux
> > > implementation for this hook.
> > >
> > > Signed-off-by: Paul Moore <paul.moore@hp.com>
> > > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> >
> > This is useful in its own right, and I would like to push it upstream for
> > 2.6.24 unless there are any objections.
> 
> Isn't it a bit late in 2.6.24 to add new functionality, especially when there
> 
> isn't an in-tree user for it in 2.6.24?
> 
> You are right, there are several users of this function currently under 
> development but I'm pretty sure all of them are targeting 2.6.25 or greater. 
> 
> With that in mind, I think the prudent thing to is to wait and push this 
> upstream for 2.6.25.

I concur with Paul. I had to delete the message I was composing because
it said exactly the same thing.

I do think that we need to put some thought into what a secid
really is and what a secctx ought to look like what with multiple
user cropping up for them. To date audit is the only out-of-LSM
user of the secctx, and assumes it's a printable text string, but
if cacheing is going to be using it as well we're approaching the
secctx being a "general" interface, and hence a part of the LSM
proper. Probably makes sense to include something in the LSM
documentation. With luck, someone who spells better than I will
beat me to it, but such an update is on my todo list.




Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
