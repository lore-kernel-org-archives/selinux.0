Subject: RE: Security Enhanced Linux distro
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Date: Fri, 15 Nov 2002 06:54:43 -0600
Message-ID: <862636C39A8D56448223B94D19757133015E91@server.westcam.com>
From: "Mark Westerman" <mark.westerman@westcam.com>
To: "Russell Coker" <russell@coker.com.au>, <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On SELinux@tycho.nsa.gov, Russell Coker wrote:

>OK.  Could you please tell us more about this distro.  What is it based on, 
>what have you done to make is a "SE Linux distro"?
>
>Is the distro based on RPM or Debian packaging systems?
>If RPM then have you solved the issues of upgrading a live system?  If so >then  please release it.

The distro uses anaconda to load the OS onto the disk and is RPM based. No we
still have not solved the upgrading a live system. One way we have been
trying to approach the problem is to look at all the files in the package and
relabel according to existing labels. The problem comes when there are new
files, and the scripts in the rpm package uses to update any existing files.
Still requires a relabel of the files system, which can take a while
depending on CPU speed, Disk speed, and how much you have loaded on you
system.


We want SELinux to be in the hands of people that might not want compile and
install kernel. The more use and feed back we get of the beta the better the
overall product SELinux will become. All changes will be GPL and we do not
plan write any non-GPL code on top of the system. We have even started to
convert the rules to XML so update to policies can be handled more
programmatically. The initial XML version uses XLST template to create the
policy.conf file and uses the checkpolicy to compile the policy.conf file.
The XML stuff is not near ready for public consumption.

Mark

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
