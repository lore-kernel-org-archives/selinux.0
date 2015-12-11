Subject: Re: Exposing secid to secctx mapping to user-space
To: Paul Moore <paul@paul-moore.com>, Daniel Cashman <dcashman@android.com>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 linux-security-module@vger.kernel.org, jeffv@google.com,
 nnk@google.com, arve@google.com
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <566B4ACE.3040301@tycho.nsa.gov>
Date: Fri, 11 Dec 2015 17:14:38 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/11/2015 02:55 PM, Paul Moore wrote:
> On Fri, Dec 11, 2015 at 1:37 PM, Daniel Cashman <dcashman@android.com> wrote:
>> Hello,
>>
>> I would like to write a patch that would expose, via selinuxfs, the
>> mapping between secids in the kernel and security contexts to
>> user-space, but before doing so wanted to get some feedback as to
>> whether or not such an endeavor could have any support upstream.  The
>> direct motivation for this is the desire to communicate calling security
>> ids/contexts over binder IPC on android for use in a user-space object
>> manager.  Passing the security ids themselves would be simpler and more
>> efficient in the critical kernel path, but they currently have no
>> user-space meaning.
>
> In general we try to avoid exposing the secid tokens outside the
> kernel, I view them as an implementation hack designed to make it
> easier to manage and operate on the security labels in the kernel.  I
> suspect you will hear something very similar from Casey and the other
> Smack developers.  Another consideration is the long standing LSM
> stacking effort, they have several good reasons for wanting to abolish
> the secid token, propagating it to userspace would make that all but
> impossible.
>
> While I'm sympathetic to your desire for less complexity and better
> performance in passing security labels, from a kernel perspective I
> think we lose too much in exporting the secid tokens outside the LSM.

To clarify, security identifiers were by design provided in the Flask 
architecture and SELinux as lightweight, non-persistent handles to 
security contexts, and exposed to userspace by the original SELinux API 
(pre-2.6, of course).  They were only removed when we transitioned to 
using extended attributes and the xattr API for file security labels, 
and we made all of the other APIs consistent as passing context strings 
seemed acceptable for proc and selinuxfs as well.  There was some 
thought to turning SIDs into proper reference-counted objects or even 
wrapping them with descriptors so that their lifecycles could be fully 
managed by the kernel, but that never happened.

Passing a security context string on every binder IPC may be too costly 
from a performance point of view (numbers would be helpful here).  I 
think this situation differs from that of stream sockets (i.e. 
getsockopt SO_PEERSEC), since they are looking at enabling passing of 
sender security label for every binder IPC (not just specific 
applications) and since binder IPC is quite different from stream socket 
IPC in its semantics and its performance.

Perhaps we could provide a new fixed-size tokenized version of the 
security context string for export to userspace that could be embedded 
in the binder transaction structure?  This could avoid both the 
limitations of the current secid (e.g. limited to 32 bits, no 
stackability) and the overhead of copying context strings on every IPC.
