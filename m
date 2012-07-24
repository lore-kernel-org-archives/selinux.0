Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6OCKCrL010175
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2012 08:20:12 -0400
Message-ID: <1343132332.2383.12.camel@moss-pluto.epoch.ncsc.mil>
Subject: SE Android: bitbucket repo created
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Tue, 24 Jul 2012 08:18:52 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

We have made our source repositories available on bitbucket.org as an
alternative to selinuxproject.org, as we've seen some issues with load
on selinuxproject.org.  To use the bitbucket.org repositories, clone the
manifests project as follows:
git clone https://seandroid@bitbucket.org/seandroid/manifests.git

If you want to use the master/seandroid branch, then you can use the
manifests/local_manifest.xml file, e.g.
cp manifests/local_manifest.xml /path/to/seandroid/.repo

If you want to use the 4.0.4 branch, you can check out the 4.0.4
manifest as follows,
cd manifests
git checkout -b seandroid-4.0.4 origin/seandroid-4.0.4
cp local_manifest.xml /path/to/seandroid-4.0.4/.repo

If you want to use the 4.1.1 branch, you can do likewise for the 4.1.1
manifest as follows,
cd manifests
git checkout -b seandroid-4.1.1 origin/seandroid-4.1.1
cp local_manifest.xml /path/to/seandroid-4.1.1/.repo

We'll be switching the manifest files on selinuxproject.org over to
using bitbucket.org in the future unless we hear that people are
experiencing problems with bitbucket.org.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
