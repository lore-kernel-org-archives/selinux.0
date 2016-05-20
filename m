Subject: Re: [PATCH] semodule: Fix the --list-modules=full example in the
 manpage
To: Petr Lautrbach <plautrba@redhat.com>,
 Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <1463498859-5911-1-git-send-email-bigon@debian.org>
 <d0b9cdf7-a58f-5639-805b-721412d1ed76@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6a2dd3fa-1b9d-f2a8-a39d-7b72ac9570a0@tycho.nsa.gov>
Date: Fri, 20 May 2016 15:48:16 -0400
MIME-Version: 1.0
In-Reply-To: <d0b9cdf7-a58f-5639-805b-721412d1ed76@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/18/2016 03:57 AM, Petr Lautrbach wrote:
> On 05/17/2016 05:27 PM, Laurent Bigonville wrote:
>> From: Laurent Bigonville <bigon@bigon.be>
>> 
>> --- policycoreutils/semodule/semodule.8 | 2 +- 1 file changed, 1
>> insertion(+), 1 deletion(-)
>> 
>> diff --git a/policycoreutils/semodule/semodule.8
>> b/policycoreutils/semodule/semodule.8 index 68e95ab..7b07c45
>> 100644 --- a/policycoreutils/semodule/semodule.8 +++
>> b/policycoreutils/semodule/semodule.8 @@ -116,7 +116,7 @@ $
>> semodule \-d alsa # Install a module at a specific priority. $
>> semodule \-X 100 \-i alsa.pp # List all modules. -$ semodule \-l
>> full +$ semodule \-\-list-modules=full
> 
> 
> It works without " " before full:
> 
> $ semodule -lfull
> 
> What about:
> 
> policycoreutils/semodule/semodule.8:
> 
> .TP -.B  \-l,\-\-list-modules=[KIND] +.B
> \-l[KIND],\-\-list-modules[=KIND] display list of installed modules
> (other than base)
> 
> # List all modules. -$ semodule \-l full +$ semodule \-lfull # Set
> an alternate path for the policy root
> 
> 
> policycoreutils/semodule/semodule.c:
> 
> printf("  -r,--remove=MODULE_NAME   remove existing module\n"); -
> printf("  -l,--list-modules=[KIND]  display list of installed 
> modules\n"); +       printf("  -l[KIND],--list-modules[=KIND]
> display list of installed modules\n"); printf("     KIND:  standard
> list highest priority, enabled modules\n");

That works for me.  Someone want to spin an actual patch?  Although
the -l argument handling is somewhat odd and non-standard; if it
wasn't already in place, I think I'd have advocated for a separate
option flag if you want the full/long listing.
