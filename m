To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@tycho.nsa.gov
References: <20180504115146.19532-1-plautrba@redhat.com>
 <d705f8cf-43c7-2882-ca42-e2d5dc90c010@tycho.nsa.gov>
 <20180504201234.GB3111@workstation>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <501c4bac-710c-fcc9-7e3a-6fba61b9fcef@tycho.nsa.gov>
Date: Mon, 7 May 2018 09:58:28 -0400
MIME-Version: 1.0
In-Reply-To: <20180504201234.GB3111@workstation>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] python/semanage/seobject.py: Fix undefined store check
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2018 04:12 PM, Petr Lautrbach wrote:
> On Fri, May 04, 2018 at 01:58:08PM -0400, Stephen Smalley wrote:
>> On 05/04/2018 07:51 AM, Petr Lautrbach wrote:
>>> From: Vit Mojzis <vmojzis@redhat.com>
>>>
>>> self.store is always a string (actual store name or "") because of
>>> semanageRecords.__init__. Fix check for not defined store.
>>>
>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1559174#c3
>>>
>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>> ---
>>>  python/semanage/seobject.py | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
>>> index ac310ea6..c76dce85 100644
>>> --- a/python/semanage/seobject.py
>>> +++ b/python/semanage/seobject.py
>>> @@ -2651,7 +2651,7 @@ class booleanRecords(semanageRecords):
>>>              self.current_booleans = []
>>>              ptype = None
>>>  
>>> -        if self.store is None or self.store == ptype:
>>> +        if self.store == "" or self.store == ptype:
>>>              self.modify_local = True
>>>          else:
>>>              self.modify_local = False
>>>
>>
>> Is there a reason you didn't use if not self.store here?
>>
> 
> There's a similar check on line 258 and this just follows the same pattern.

Ok, I don't have a strong opinion on it either way, but noticed that it was recommended
to use not self.store in that bugzilla entry, comment #9, and was claimed to have been changed
in comment #10.  Up to you.
