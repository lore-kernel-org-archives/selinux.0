Subject: Re: [PATCH] semanage: fix error message for fcontext -m
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <1471519081-26417-1-git-send-email-mvadkert@redhat.com>
 <a910016c-e086-cb75-464b-a17b992167e8@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9102ff8e-a7bc-7941-3ed8-70a80cd31ecc@tycho.nsa.gov>
Date: Thu, 18 Aug 2016 09:01:59 -0400
MIME-Version: 1.0
In-Reply-To: <a910016c-e086-cb75-464b-a17b992167e8@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/18/2016 07:51 AM, Dominick Grift wrote:
> On 08/18/2016 01:18 PM, Miroslav Vadkerti wrote:
>> The type must be a file of device type, not a port type.
>> 
>> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com> --- 
>> policycoreutils/semanage/seobject.py | 2 +- 1 file changed, 1
>> insertion(+), 1 deletion(-)
>> 
>> diff --git a/policycoreutils/semanage/seobject.py
>> b/policycoreutils/semanage/seobject.py index a6681f0..a34d20d
>> 100644 --- a/policycoreutils/semanage/seobject.py +++
>> b/policycoreutils/semanage/seobject.py @@ -1937,7 +1937,7 @@
>> class fcontextRecords(semanageRecords): if serange == "" and
>> setype == "" and seuser == "": raise ValueError(_("Requires
>> setype, serange or seuser")) if setype and setype not in
>> self.valid_types: -            raise ValueError(_("Type %s is
>> invalid, must be a port type") % setype) +            raise
>> ValueError(_("Type %s is invalid, must be a file or device type")
>> % setype)
>> 
>> self.validate(target)
>> 
>> 
> 
> Hard-coded reference policy specific type attributes in seobject 
> (self.valid_types)

That's true, but not introduced by this patch.
Another example where we need some kind of key=value configuration
mapping that can be read by semanage/seobject rather than hardcoding
them.  Preferably automatically generated during refpolicy build so
that we don't have to manually keep it in sync.

For example,
valid_fcontext_type_attributes=file_type,device_type
