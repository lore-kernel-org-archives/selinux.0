Message-ID: <41DEDCF0.1020708@redhat.com>
Date: Fri, 07 Jan 2005 14:03:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: FYI: A couple of Interesting updates to Userspace in Fedora Rawhide
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

    *   Updates to fixfiles in policycoreutils-1.19.3-1

    We have updated fixfiles to front end restorecon and setfiles.
    Now fixfiles can update your whole system by default
    fixfiles relabel  (Uses setfiles under the covers).
    It can restore particular RPM packages
    fixfiles -R coreutils,policycoreutils restore  (Uses restorecon)
    Or it can restore individual directories.
    fixfiles restore /usr /etc /var  (Users restorecon)

    *     Fixes to find (findutils-4.1.20-8)

    Find now allow you to specify a "file name GLOB" when specifying
    --context
    find / --context "*:shlib_t" -printf "%p %Z \n"


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
