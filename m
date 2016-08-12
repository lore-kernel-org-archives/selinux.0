Subject: Re: Restricting network communications of mounted filesystems
To: Colin Powers <Colin.Powers@nexor.com>,
 "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
References: <DB6PR0301MB25686B836200CDD7728F63829E1E0@DB6PR0301MB2568.eurprd03.prod.outlook.com>
 <e3fe3e6a-a03f-cc2f-0b98-e2b192586199@tycho.nsa.gov>
 <DB6PR0301MB2568201D5ADD566A765EFFA89E1F0@DB6PR0301MB2568.eurprd03.prod.outlook.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e8932fd0-0069-fc55-6750-468656e81b1d@tycho.nsa.gov>
Date: Fri, 12 Aug 2016 09:10:48 -0400
MIME-Version: 1.0
In-Reply-To: <DB6PR0301MB2568201D5ADD566A765EFFA89E1F0@DB6PR0301MB2568.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/12/2016 04:08 AM, Colin Powers wrote:
> Thanks Stephen, that's really interesting.
> 
> I can solve my problem another way using a userspace process, it will just be a bit less convenient than using mount. I have a security need to prevent a compromised network process from accessing other network interfaces.
> 
> Is this scenario also true for other types of file shares that could be mounted, e.g. NFS, FTP (via curlftpfs)?

Generally a socket is only created at mount time, and used for requests
from all clients, so it would be true for other remote filesystems as
well.  In some cases, the socket may be created by userspace (e.g.
likely the case for curlftpfs; might also be true for earlier versions
of NFS where the MOUNT protocol was performed by userspace) and
therefore be labeled with the context of the mounting process; in other
cases, the socket may be created and kept private to the kernel, and is
therefore labeled with the kernel context.  Regardless, the socket
context is not going to reflect the context of the individual clients
and therefore won't help with this kind of access control.
