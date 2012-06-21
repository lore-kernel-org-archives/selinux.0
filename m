Message-ID: <1340306672.4234.112.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: AOSP commit 0cd29e3a3268f99ef0cb72a51782a35f407de1ae to
 manifests cause failure
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 21 Jun 2012 15:24:32 -0400
In-Reply-To: <CAFftDdq=pKM7zheXbV=ONnbJ90TFVSQL-Uk6S2J3diyfT6=nUw@mail.gmail.com>
References: 
	<CAFftDdq=pKM7zheXbV=ONnbJ90TFVSQL-Uk6S2J3diyfT6=nUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-06-21 at 11:49 -0700, William Roberts wrote:
> Commit 0cd29e3a3268f99ef0cb72a51782a35f407de1ae in the manifest for
> AOSP changed dalvik to dalvik2, not sure how you guys are managing
> this switch but it broke the build. Currently I set my head back by
> one on the manifest to work around this.

Seems to be two options:
- repo init -b master-dalvik to keep using dalvik/libcore,
- modify local_manifest.xml to specify dalvik2/libcore2 in the
remove-project lines only.

Still trying to understand what they did and why.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
