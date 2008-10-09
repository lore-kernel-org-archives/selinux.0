Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m99NUaV9000682
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 19:30:36 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m99NUa8h000469
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 23:30:36 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m99NUXBC029836
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 19:30:33 -0400
Message-ID: <48EE9415.6050902@redhat.com>
Date: Fri, 10 Oct 2008 09:30:29 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: Archiving Files with tar/star
References: <48EDAE09.8070903@redhat.com> <48EDEFB9.9090702@redhat.com>
In-Reply-To: <48EDEFB9.9090702@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Murray McAllister wrote:

> The only point I often bring up is if you have a tar file without
> extended attributes, or want the extended attributes to match the policy
> of the destination machine, you should run it through restorecon.
> 
> 
> tar xvf file.tgz | restorecon -f -
> 
> Would reset the file context on disk after the extraction.
Does this only apply to the tar file itself, not the files in it? On 
rawhide the extracted files (that have extended attributes) inherit the 
type of the directory they are being extracted in.

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
