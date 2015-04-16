Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3GI6sJX002981
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 14:06:55 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3GI6olP008168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 14:06:50 -0400
Message-ID: <552FFA39.3030909@redhat.com>
Date: Thu, 16 Apr 2015 14:06:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Florian Weimer <fweimer@redhat.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Impersonating a process for file creation purposes
References: <552F80C8.9060809@redhat.com>
In-Reply-To: <552F80C8.9060809@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 04/16/2015 05:28 AM, Florian Weimer wrote:
> The ABRT coredump handler has code to emulate default core file creation
> (as if no such pipe-based handler was installed).  The handler runs in a
> separate process, initially as root.  Currently, the handler just
> switches effective IDs and creates the file.  This does not replicate
> the SELinux context of the zombie process.
>
> Is there a way to do that?   Is there some recommended way to inherit
> all the security-related process attributes?
>
You have two choices.  1 would be to setcon() call to change the label
to the user process.

The other choice would be to ask the kernel what label this user would
create if he created a file
in the specified directory.  This is what systemd does.
