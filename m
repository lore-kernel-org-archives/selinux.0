Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3RKK2ga014664
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 16:20:06 -0400
Received: from smtp105.prem.mail.ac4.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p3RKJx1e024729
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 20:20:00 GMT
Message-ID: <4DB87A6B.7060805@schaufler-ca.com>
Date: Wed, 27 Apr 2011 13:19:55 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Roberto Sassu <roberto.sassu@polito.it>
CC: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org,
        zohar@linux.vnet.ibm.com, safford@watson.ibm.com,
        tyhicks@linux.vnet.ibm.com, kirkland@canonical.com,
        ecryptfs-devel@lists.launchpad.net, eparis@redhat.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov, viro@zeniv.linux.org.uk
Subject: Re: [RFC][PATCH 0/7] File descriptor labeling
References: <1303907657-18366-1-git-send-email-roberto.sassu@polito.it>
In-Reply-To: <1303907657-18366-1-git-send-email-roberto.sassu@polito.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/27/2011 5:34 AM, Roberto Sassu wrote:
> File descriptor labeling issue
>
> Actually SELinux and SMACK assign to file descriptors the same label of the
> opening process and use it in LSM hooks security_file_permission(),
> security_file_fcntl() and others to verify if the 'current' process has the
> rights to perform the requested operation.
>
> Using the credentials of the 'current' process may be not appropriate in
> case a file descriptor is opened by a kernel service (i.e. a filesystem)
> and made shared among user processes. For instance, in a system with
> SELinux and eCryptfs, if the process A opens an encrypted file, eCryptfs
> obtains a file descriptor to access the correspondent inode in the lower
> filesystem, labeled with the A's label.
>
> If the process B accesses the same encrypted file, it needs the 'use'
> permission on the A's label other than permissions for the lower inode.
> However, if B is the first accessing process, A needs the 'use' permission
> on the B's label.

I am having trouble understanding the argument. I will pose my
question in Smack terms, as I can speak most definitively in them.

A process running with a Smack label "A" creates a file, and that
file gets labeled "A", as it ought. If eCryptfs is behaving correctly
this ought not change. If eCryptfs in encrypting the label it needs
to do so in such a way as to be able to decrypt it prior to
presentation to the vfs layer, where it will be used in an access
check. When the process running with a Smack label "B" comes along
the vfs code will check the fetched and possibly decrypted "A"
against "B" and, unless there is an explicit Smack rule in place
granting "B" access to "A", fail.

What is the problem? What is eCryptfs doing that prevents this
from working?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
