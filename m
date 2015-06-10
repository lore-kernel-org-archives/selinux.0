Date: Wed, 10 Jun 2015 19:06:35 +0900 (JST)
Message-Id: <20150610.190635.1866127952891120915.yamato@redhat.com>
To: sds@tycho.nsa.gov
Subject: Re: [PATCH] sepolicy-generate: Handle more reserved port types
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <5571BBE6.7040409@tycho.nsa.gov>
References: <1433502571-27116-1-git-send-email-yamato@redhat.com>
 <5571BBE6.7040409@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 05 Jun 2015 11:10:30 -0400, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 06/05/2015 07:09 AM, Masatake YAMATO wrote:
>> Currently only reserved_port_t, port_t and hi_reserved_port_t
>> are handled as special when making a ports-dictionary.
>> However, as fas as corenetwork.te.in of serefpolicy,
>> both unreserved_port_t and ephemeral_port_t also handled
>> in the same way.
>> 
>> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>> ---
>>  policycoreutils/sepolicy/sepolicy/generate.py | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycoreutils/sepolicy/sepolicy/generate.py
>> index 6b53035..446eb39 100644
>> --- a/policycoreutils/sepolicy/sepolicy/generate.py
>> +++ b/policycoreutils/sepolicy/sepolicy/generate.py
>> @@ -90,7 +90,9 @@ def get_rpm_nvr_list(package):
>>  def get_all_ports():
>>      dict = {}
>>      for p in sepolicy.info(sepolicy.PORT):
>> -        if p['type'] == "reserved_port_t" or \
>> +        if p['type'] == "ephemeral_port_t" or \
>> +                p['type'] == "unreserved_port_t" or \
>> +                p['type'] == "reserved_port_t" or \
>>                  p['type'] == "port_t" or \
>>                  p['type'] == "hi_reserved_port_t":
>>              continue
>> 
> 
> Can you explain this a bit further?  What is the difference in behavior

I found this is a distribution own issue; nothing to do
with upstream code.


This is the corenetwork.te.in of the a distribution.

    portcon tcp 512-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
    portcon udp 512-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
    portcon tcp 1-511 gen_context(system_u:object_r:reserved_port_t, s0)
    portcon udp 1-511 gen_context(system_u:object_r:reserved_port_t, s0)
    portcon tcp 1024-32767 gen_context(system_u:object_r:unreserved_port_t, s0)
    portcon tcp 32768-61000 gen_context(system_u:object_r:ephemeral_port_t, s0)
    portcon tcp 61001-65535 gen_context(system_u:object_r:unreserved_port_t, s0)
    portcon udp 1024-32767 gen_context(system_u:object_r:unreserved_port_t, s0)
    portcon udp 32768-61000 gen_context(system_u:object_r:ephemeral_port_t, s0)
    portcon udp 61001-65535 gen_context(system_u:object_r:unreserved_port_t, s0)

Let's forget my patch; and sorry for making noise.

Masatake YAMATO


> for sepolicy generate after your change?  Why do we want to treat these
> types differently?  And is this change sufficient, or do we need to
> recognize and handle these cases elsewhere (e.g. I see some handling
> already in sepolicy/network.py for unreserved_port_t or
> unreserved_port_type but not for ephemeral)?  Similarly, we have
> checking in semanage/seobject.py for reserved_port_t but not for these
> other types.
> 
> More broadly, it would be better if this list of types that requires
> special handling could itself be specified in policy so that we don't
> hardcode any knowledge of types in the tools.
> 
