Subject: Re: useradd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200910211552.49980.russell@coker.com.au>
References: <200910211552.49980.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 21 Oct 2009 08:30:10 -0400
Message-Id: <1256128210.4061.173.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-10-21 at 15:52 +1100, Russell Coker wrote:
> It seems impossible to have policy that allows useradd to always get the right 
> context for the new home directory.
> 
> I am thinking of patching useradd such that if the -m option is given then it 
> will spawn the command "restorecon -R /home/$USER" - or alternately putting 
> in SE Linux code to match the context for each file or directory that is 
> copied from /etc/skel .
> 
> What do you think?

The useradd in shadow-utils is already modified to:
a) To add the user to seusers via semanage if the -Z option is used to
specify a SELinux user, and
b) set the fscreate context based on matchpathcon() for the user home
dir prior to creating the files there.

So it should already do the right thing.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
