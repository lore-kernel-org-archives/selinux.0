Subject: Re: selinux: Delete an error message for a failed memory allocation
 in policydb_read()
To: Paul Moore <paul@paul-moore.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <c589a851-2bf6-c44f-1df7-11f242285a73@users.sourceforge.net>
 <CAHC9VhTf6LdUNJHV9G+YA=P1rj78v5WKG8v+QNoFGZ6DA+mDmQ@mail.gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <ecce7c5c-cbeb-5896-ec12-26c97619c102@users.sourceforge.net>
Date: Fri, 24 Mar 2017 13:13:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTf6LdUNJHV9G+YA=P1rj78v5WKG8v+QNoFGZ6DA+mDmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

>> Omit an extra message for a memory allocation failure in this function.
>>
>> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>  security/selinux/ss/policydb.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> I'm not going to remove an error message without some better reasoning
> in the patch description.  Providing a link to slides is fine, but
> your commit message needs to convey the important information and I
> don't think that is the case here (what happens when that URL dies?).

Do you need an explicit reminder there that the function “kmalloc” provides its own
error reporting already because the flag “__GFP_NOWARN” was not passed here?

Regards,
Markus
