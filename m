Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95LFcrT000153
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 17:15:38 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95LEUPe023096
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 21:14:30 GMT
Date: Tue, 5 Oct 2004 22:26:44 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Patch to restorecon to add -R switch
Message-ID: <20041005212644.GL25251@lkcl.net>
References: <41584DCA.7030006@redhat.com> <1096999568.3878.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096999568.3878.126.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 05, 2004 at 02:06:08PM -0400, Stephen Smalley wrote:
> On Mon, 2004-09-27 at 13:28, Daniel J Walsh wrote:
> > Also patch adds some fixed for fixfiles.
> 
> > --- policycoreutils-1.17.5/scripts/fixfiles.rhat	2004-08-30 11:46:47.000000000 -0400
> > +++ policycoreutils-1.17.5/scripts/fixfiles	2004-09-24 18:46:15.672622592 -0400
> > @@ -36,6 +36,8 @@
> >  FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | reiserfs ).*\(ro/{print $3}';`
> >  FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
> >  SELINUXTYPE="targeted"
> > +FCFILE=`mktemp /var/tmp/file_contexts.XXXXXXXXXX`
> > +trap "rm -f $FCFILE; exit 2" 1 2 3 5 15 
> 
> I thought we had agreed that generating a temporary FCFILE was
> undesirable and unnecessary, given that:
> a) it requires allow setfiles to take temporary files as input (not
> allowed by strict policy),
> b) /dev nodes are no longer touched by setfiles anyway due to use of
> tmpfs and udev.
 
  could somebody _please_ explain to me why /.dev should
  also not be touched (listed explicitly in files/types.fc),
  _particularly_ when the xattrs could get damaged, such that
  a system [which _doesn't_ do tmpfs+udev in initrd but _does_
  do tmpfs+udev later] could be put into a non-bootable state?

  l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
