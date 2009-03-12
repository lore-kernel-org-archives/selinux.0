Message-ID: <49B90E2D.9010400@redhat.com>
Date: Thu, 12 Mar 2009 09:29:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joe Nall <joe@nall.com>, SELinux List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Help with python seobject.loginRecords
References: <1BF3FC9F-9D76-4CF5-B67E-DFE8216038FA@nall.com>	 <49B8126B.9060501@redhat.com>	 <F1007BB4-8898-4A05-B09A-4FB1EF8519A2@nall.com>	 <49B823CD.3090409@redhat.com> <1236805217.14649.89.camel@localhost.localdomain>
In-Reply-To: <1236805217.14649.89.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------040402020000000805000101"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040402020000000805000101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 03/11/2009 05:00 PM, Stephen Smalley wrote:
> On Wed, 2009-03-11 at 16:49 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Joe Nall wrote:
>>> On Mar 11, 2009, at 2:35 PM, Daniel J Walsh wrote:
>>>
>>>> On 03/11/2009 12:15 PM, Joe Nall wrote:
>>>>> I need to add login mappings in python firstboot modules during system
>>>>> configuration. In my first module a simple:
>>>>>
>>>>> seobject.loginRecords().add(username, "siterep_u",
>>>>> "SystemLow-SystemHigh")
>>>>>
>>>>> works. In subsequent modules, I get an exception:
>>>>>
>>>>> libsemanage.enter_rw: this operation requires a transaction
>>>>> libsemanage.enter_rw: could not enter read-write section
>>>>> Traceback (most recent call last):
>>>>> File "./t", line 6, in<module>
>>>>> seobject.loginRecords().add("test3", "sysadm_u", "SystemLow-SystemHigh")
>>>>> File "/usr/lib64/python2.5/site-packages/seobject.py", line 442, in add
>>>>> raise error
>>>>> ValueError: Could not add login mapping for test3
>>>>>
>>>>> What is the right way to do this?
>>>>>
>>>>> joe
>>>>>
>>>>>
>>>>> --
>>>>> This message was distributed to subscribers of the selinux mailing list.
>>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>>>> with
>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>> Probably an MLS issue.  firtstboot is running in a context that is not
>>>> allowed to lock/manage selinux.
>>> I'm installing in permissive and switching to enforcing after firstboot.
>>> You are correct that firstboot_t doesn't have the policy for all the
>>> stuff I'm trying to do yet.
>>>
>>>> You probably should exec semanage rather then calling seobject so you
>>>> could do a transition and not have to give a huge app like first boot
>>>> the ability to manage security policy.
>>> That is what is installing right now. I would still like an
>>> explanation/code snippet of correct usage for future use
>>>
>>> joe
>>>
>>>
>> This works on F10 Targeted policy
>>
>> # python -c "import seobject; seobject.loginRecords().add("pwalsh",
>> "staff_u", "s0")
>> # python -c 'import seobject; seobject.loginRecords().delete("pwalsh")'
>>
>> Could it be a translation problem?
>
> Try running multiple calls within the same python interpreter.
> I think seobject.py isn't using libsemanage correctly.  For example, in
> add(), you do:
>                         self.begin()
>                          self.__add(name, sename, serange)
>                          self.commit()
> but begin() only ever invokes semanage_begin_transaction() the very
> first time:
>         def begin(self):
>                 if self.transaction:
>                        return
>                 rc = semanage_begin_transaction(self.sh)
>
> So after the first commit(), you'll start failing.
>
I think this patch fixes the transaction patch in semanage.

--------------040402020000000805000101
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.16 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.62/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2009-02-18 16:44:47.000000000 -0500
+++ policycoreutils-2.0.62/semanage/semanage	2009-03-12 09:22:45.000000000 -0400
@@ -464,10 +464,10 @@
                       else:
                              fd = open(input, 'r')
                       trans = seobject.semanageRecords(store)
-                      trans.begin()
+                      trans.start()
                       for l in fd.readlines():
                              process_args(mkargv(l))
-                      trans.commit()
+                      trans.finish()
                else:
                       process_args(sys.argv[1:])
 			
diff --exclude-from=exclude --exclude=sepolgen-1.0.16 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.62/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2008-11-14 17:10:15.000000000 -0500
+++ policycoreutils-2.0.62/semanage/seobject.py	2009-03-12 09:25:27.000000000 -0400
@@ -281,15 +281,20 @@
                global handle
                       
                if handle != None:
-                      self.transaction = True
                       self.sh = handle
                else:
                       self.sh=get_handle(store)
-                      self.transaction = False
+               self.transaction = False
 
         def deleteall(self):
                raise ValueError(_("Not yet implemented"))
 
+        def start(self):
+               if self.transaction:
+                      raise ValueError(_("Semanage transaction already in progress"))
+               self.begin()
+               self.transaction = True
+
         def begin(self):
                if self.transaction:
                       return
@@ -303,6 +308,12 @@
                if rc < 0:
                       raise ValueError(_("Could not commit semanage transaction"))
 
+        def finish(self):
+               if not self.transaction:
+                      raise ValueError(_("Semanage transaction not in progress"))
+               self.transaction = False
+               self.commit()
+
 class permissiveRecords(semanageRecords):
 	def __init__(self, store):
                semanageRecords.__init__(self, store)

--------------040402020000000805000101--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
