Subject: Re: Strange AVC with latest rawhide kernel.
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@redhat.com>, pmoore@redhat.com
References: <1456423369.3702.42.camel@redhat.com>
 <56CF4574.3030709@tycho.nsa.gov> <1456426779.3702.52.camel@redhat.com>
 <56CF523A.7000503@tycho.nsa.gov> <1456429021.31341.34.camel@redhat.com>
 <56CF5A54.7020600@tycho.nsa.gov> <1456432571.3702.69.camel@redhat.com>
Cc: selinux@tycho.nsa.gov
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <56D41917.70608@redhat.com>
Date: Mon, 29 Feb 2016 11:10:31 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1456432571.3702.69.camel@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/25/16 21:36, Daniel J Walsh wrote:
> On Thu, 2016-02-25 at 14:47 -0500, Stephen Smalley wrote:
>> On 02/25/2016 02:37 PM, Eric Paris wrote:
>>>
>>> You added a type bounds right before this broke...  Does the parent
>>> type have entrypoint? If not, maybe that's where it got stripped...
>> That would match the behavior he described (although he should get
>> an 
>> audit message of the form op=security_compute_av reason=bounds.. in 
>> audit.log or dmesg in that case).  The kernel automatically reduces 
>> permissions as required by typebounds.  The corresponding logic
>> never 
>> made its way into the libsepol compute_av code, so audit2why
>> wouldn't 
>> know about it, and sesearch merely searches for TE rules; it doesn't
>> do 
>> anything about typebounds.  We should probably update libsepol 
>> compute_av (for that, and eventually for xperms).
> 
> Eric is right.  I added the following policy and got the error again.
> 
> policy_module(mypol, 1.0)
> 
> require {
> 	type svirt_lxc_net_t;
> 	type docker_t;
> }
> typebounds docker_t svirt_lxc_net_t;
> 
> 
> Then I added this policy and it worked.
> 
> policy_module(mypol, 1.0)
> 
> require {
> 	type svirt_lxc_net_t;
> 	type docker_t;
> 	type svirt_sandbox_file_t;
> }
> allow docker_t svirt_sandbox_file_t:file entrypoint;
> typebounds docker_t svirt_lxc_net_t;

Were you looking for SELINUX_ERR in audit.log? This is a design of
typebounds -> bounding domains need to have required bounded permissions.

So I have

type bounded_t;
type bounding_t;

an I am getting

type=SELINUX_ERR msg=audit(1456737948.283:273): op=security_compute_av
reason=bounds scontext=system_u:system_r:bounded_t:s0-s0:c0.c1023
tcontext=system_u:object_r:bin_t:s0 tclass=file perms=entrypoint

in my test because I am missing

allow bounding_t bin_t:file entrypoint;

It is also a reason why it is so hard to make sandbox working with
typebounds. Of course it is more about the current policy language and
his limitations and we will challenge them also here.

> 
> So typebounds removed the entrypoint access from svirt_lxc_net_t, but
> none of the tools realized this.
> 



-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
