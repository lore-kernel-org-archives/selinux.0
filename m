Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5R9c7rT007523
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 05:38:07 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5R9br5h005604
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 09:37:53 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 27 Jun 2004 09:38:05 -0000
Date: Sun, 27 Jun 2004 09:34:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: fsck deleting extended attributes
Message-ID: <20040627093439.GA12052@lkcl.net>
References: <20040626220355.GL3559@lkcl.net> <200406271858.24058.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406271858.24058.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 27, 2004 at 06:58:24PM +1000, Russell Coker wrote:
> On Sun, 27 Jun 2004 08:03, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > the issue is that if a system is switched off without shutdown and
> > the filesystem is damaged, such that some extended attributes are
> > deleted on an fsck, that's it - the file cannot be accessed!
> 
> The fact that a file without a label is inaccessible to most programs is a bug 
> not a feature.  You wouldn't want /etc/shadow to lose it's label and give 
> away passwords...
> 
> No matter what you do there are situations in which a file system can be 
> messed up beyond the ability of fsck to fix it.  By default there are many 
> situations in which fsck will want to operate in manual mode (you have to 
> edit something under /etc to have fsck run with -f to have it recover from 
> most errors without intervention).
> 
> > i am setting up a system where the users will NOT be told what
> > the root password is, nor will they be given a user login
> > (they will be given an automatic KDE login), and there is
> > ABSOLUTELY no chance of either user support or admin support.
> 
> How about mounting the root fs R/O so that it can't be messed up and then 
> having /var and /home relabelled on some schedule (eg every 5th boot).
> 
> > a) get fsck.ext2 fixed?
> 
> I think it's already as good as it's going to get in this regard.
> 
> > b) forcibly run make -C /etc/selinux relabel from /etc/init.d/checkfs.sh
> 
> Yes, but not every boot.
 
 i modified /etc/init.d/checkfs.sh as follows:

    echo "Checking all file systems..."
    fsck $spinner -R -A $fix $force
    if [ $? -gt 1 ]
            fsck $spinner -R -A $fix -y
            if [ $? -gt 1 ]
            then
              echo
              echo "fsck failed.  Please repair manually."
              echo
              echo "CONTROL-D will exit from this shell and continue system startup."
              echo
              # Start a single user shell on the console
              /sbin/sulogin $CONSOLE
            else

              # first file system check failed: second one forced
              # "yes" to repair so just in case we re-run the
              # relabelling of se/linux extended attributes...

              make -C /etc/selinux relabel
            fi
    then
    fi

 in other words, a [hopefully!] non-damaging fsck is done first,
 with detection that goes "eek", does a forced fsck and then
 runs relabel.

 i _hope_ that it's done under a context where the relabel can
 actually work!

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
