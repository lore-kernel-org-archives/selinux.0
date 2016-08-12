Subject: Re: [PATCH] semanage: correct fcontext auditing
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
 <cd0a96df-5daf-8231-d57e-4be544c923a0@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b3b0b9b4-19ec-9520-7adc-f80d84d635c6@tycho.nsa.gov>
Date: Fri, 12 Aug 2016 10:58:27 -0400
MIME-Version: 1.0
In-Reply-To: <cd0a96df-5daf-8231-d57e-4be544c923a0@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/12/2016 10:22 AM, Dominick Grift wrote:
> On 08/12/2016 03:57 PM, Miroslav Vadkerti wrote:
>> For modify action actually audit the selinux type, i.e. use
>> setype variable.
>> 
>> For deleting equal fcontext rules do not audit ftype, as the
>> ftype value for equal rules makes little sense.
>> 
>> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com> --- 
>> policycoreutils/semanage/seobject.py | 4 ++-- 1 file changed, 2
>> insertions(+), 2 deletions(-)
>> 
>> diff --git a/policycoreutils/semanage/seobject.py
>> b/policycoreutils/semanage/seobject.py index 786ed0e..8d3088c
>> 100644 --- a/policycoreutils/semanage/seobject.py +++
>> b/policycoreutils/semanage/seobject.py @@ -1992,7 +1992,7 @@
>> class fcontextRecords(semanageRecords): if not seuser: seuser =
>> "system_u"
> 
> system_u is reference policy specific. this is selinux user space
> not reference policy user space.

Yes, that's pre-existing though (not added by this patch), and
unfortunately pervasive throughout seobject.py.

I guess we'll need to decide how to provide this information so that
it doesn't have to be hardcoded in seobject.py, e.g. yet another
policy configuration file with default values for each security
context field?

> 
>> 
>> -        self.mylog.log_change("resrc=fcontext op=modify %s
>> ftype=%s tcontext=%s:%s:%s:%s" %
>> (audit.audit_encode_nv_string("tglob", target, 0),
>> ftype_to_audit[ftype], seuser, "object_r", type, serange)) +
>> self.mylog.log_change("resrc=fcontext op=modify %s ftype=%s
>> tcontext=%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob",
>> target, 0), ftype_to_audit[ftype], seuser, "object_r", setype,
>> serange))
>> 
>> def modify(self, target, setype, ftype, serange, seuser): 
>> self.begin() @@ -2030,7 +2030,7 @@ class
>> fcontextRecords(semanageRecords): self.equiv.pop(target) 
>> self.equal_ind = True
>> 
>> -            self.mylog.log_change("resrc=fcontext
>> op=delete-equal %s ftype=%s" %
>> (audit.audit_encode_nv_string("tglob", target, 0),
>> ftype_to_audit[ftype])) +
>> self.mylog.log_change("resrc=fcontext op=delete-equal %s" %
>> (audit.audit_encode_nv_string("tglob", target, 0)))
>> 
>> return
>> 
>> 
> 
> 
> 
> 
> _______________________________________________ Selinux mailing
> list Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
> "help" to Selinux-request@tycho.nsa.gov.
> 
