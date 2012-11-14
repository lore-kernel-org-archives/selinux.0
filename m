Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAE4WwEY018962
	for <selinux@tycho.nsa.gov>; Tue, 13 Nov 2012 23:32:59 -0500
Message-ID: <50A31EF5.1050801@davequigley.com>
Date: Tue, 13 Nov 2012 23:32:53 -0500
From: Dave Quigley <dpquigl@davequigley.com>
MIME-Version: 1.0
To: Steve Dickson <SteveD@redhat.com>
CC: "J. Bruce Fields" <bfields@fieldses.org>,
        "David P. Quigley" <selinux@davequigley.com>,
        trond.myklebust@netapp.com, sds@tycho.nsa.gov,
        linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: Labeled NFS [v5]
References: <1352700947-3915-1-git-send-email-dpquigl@davequigley.com> <20121112152335.GH30713@fieldses.org> <50A116F0.5050404@davequigley.com> <20121112160959.GK30713@fieldses.org> <50A16269.4060601@RedHat.com> <50A1A4EE.7030507@davequigley.com> <50A24345.8080309@RedHat.com>
In-Reply-To: <50A24345.8080309@RedHat.com>
Content-Type: multipart/mixed;
 boundary="------------080501030904020300030304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080501030904020300030304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/2012 7:55 AM, Steve Dickson wrote:
>
>
> On 12/11/12 20:39, Dave Quigley wrote:
>> If you're ok with non Fedora kernel images I can try to put up a tree either tonight or tomorrow with the patches that you just need to build and install. That plus the one patch for nfs-utils should make everything work.
> I'm good with that....
>
> steved.
>

Ok so if you go to http://www.selinuxproject.org/git you will see a repo 
for lnfs and lnfs-patchset. The instructions at 
http://www.selinuxproject.org/page/Labeled_NFS give you a better 
indication on how to pull the trees. I've attached a patch for NFS utils 
which gives support for security_label/nosecurity_label in your 
/etc/exports file. I've also attached a script called setup which should 
build a test directory called /export with a copy of /var/www under it 
which should be labeled properly. It does all the proper SELinux 
commands to make sure labeling is correct. Once you have that setup just 
mount -t nfs localhost:/ /mnt/lnfs (or wherever you want) and you should 
be good to go. Just ls -Z in /mnt/lnfs/var and check to make sure the 
labels are the same as /export/var. It should have the labels showing up 
in the network transfer. If you have any problems just let me know and I 
can try to help figure them out.

Dave

--------------080501030904020300030304
Content-Type: text/plain; charset=windows-1252;
 name="0001-Add-support-to-specify-which-exports-will-provide-La.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-support-to-specify-which-exports-will-provide-La.pa";
 filename*1="tch"


--------------080501030904020300030304--
