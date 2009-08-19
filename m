Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7JKLZwt020035
	for <selinux@tycho.nsa.gov>; Wed, 19 Aug 2009 16:21:35 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7JKMgAM016219
	for <selinux@tycho.nsa.gov>; Wed, 19 Aug 2009 20:22:42 GMT
Message-ID: <4A8C5EC7.20300@redhat.com>
Date: Wed, 19 Aug 2009 16:21:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to semanage
References: <C6B1CC3A.A9DFC%csellers@tresys.com>
In-Reply-To: <C6B1CC3A.A9DFC%csellers@tresys.com>
Content-Type: multipart/mixed;
 boundary="------------070106080907020203070105"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070106080907020203070105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 08/19/2009 03:35 PM, Chad Sellers wrote:
> On 8/19/09 3:20 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> 
>> On 08/19/2009 09:53 AM, Joshua Brindle wrote:
>>> Daniel J Walsh wrote:
>>>> On 08/18/2009 05:41 PM, Chad Sellers wrote:
>>>>> On 8/18/09 5:35 PM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>>>>>
>>>>>> On 08/17/2009 05:45 PM, Chad Sellers wrote:
>>>>>>> On 7/17/09 6:10 AM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>>>>>>>
>>>>>>>> Ok lets try the patch again.
>>>>>>>>
>>>>>>>> Added equal patch (spelled correctly.)
>>>>>>>> Beginning to add modules support to consolidate on one management
>>>>>>>> command.
>>>>>>>> Eventually replace semodule/setsebool with semanage command.
>>>>>>>> Some white space fixing in seobject.py
>>>>>>> As I said previously, I've split this patch into the 3 separate
>>>>>>> patches
>>>>>>> (whitespace, equal, modules) for review purposes, as it was too
>>>>>>> difficult to
>>>>>>> get through with the 3 different patches interspersed. Please try
>>>>>>> to split
>>>>>>> up functional patches in the future.
>>>>>>>
>>>>>>> This message will apply to the modules patch only.
>>>>>>>
>>>>>>>> diff --git a/policycoreutils/semanage/semanage
>>>>>>>> b/policycoreutils/semanage/semanage
>>>>>>>> index 1688d85..072453d 100644
>>>>>>>> --- a/policycoreutils/semanage/semanage
>>>>>>>> +++ b/policycoreutils/semanage/semanage
>>>>>>>> @@ -44,7 +44,7 @@ if __name__ == '__main__':
>>>>>>>>                  text = _("""
>>>>>>>>   semanage [ -S store ] -i [ input_file | - ]
>>>>>>>>
>>>>>>>> -semanage
>>>>>>>> {boolean|login|user|port|interface|node|fcontext|translation}
>>>>>>>> -{l|D}
>>>>>>>> [-n]
>>>>>>>> +semanage
>>>>>>>> {module,boolean|login|user|port|interface|node|fcontext|translation}
>>>>>>>> -{l|D} [-n]
>>>>>>>>   semanage login -{a|d|m} [-sr] login_name | %groupname
>>>>>>>>   semanage user -{a|d|m} [-LrRP] selinux_name
>>>>>>>>   semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
>>>>>>>> @@ -53,7 +53,8 @@ semanage node -{a|d|m} [-tr] [ -p protocol ] [-M
>>>>>>>> netmask]
>>>>>>>> addr
>>>>>>>>   semanage fcontext -{a|d|m} [-frst] [-e path ] file_spec
>>>>>>>>   semanage translation -{a|d|m} [-T] level
>>>>>>>>   semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean |
>>>>>>>> boolean_file
>>>>>>>> -semanage permissive -{d|a} type
>>>>>>>> +semanage permissive -{a|d} type
>>>>>>>> +semanage module -{a|d|} module
>>>>>>>>
>>>>>>>>   Primary Options:
>>>>>>>>
>>>>>>>> @@ -68,6 +69,7 @@ Primary Options:
>>>>>>>>       -h, --help       Display this message
>>>>>>>>       -n, --noheading  Do not print heading when listing OBJECTS
>>>>>>>>           -S, --store      Select and alternate SELinux store to
>>>>>>>> manage
>>>>>>>> +        --dontaudit      Turn on or off dontaudit rules
>>>>>>>>
>>>>>>> Need to specify that this takes an integer argument (1 or 0) here.
>>>>>>> Also,
>>>>>>> need to specify which command this is valid for, which appears to
>>>>>>> be the
>>>>>>> module command. Why is this an option for the module command? It
>>>>>>> doesn't
>>>>>>> seem to have anything to do with a particular module. Should this
>>>>>>> just be
>>>>>>> its own command?
>>>>>>>
>>>>>> I think it should be just for the modules command.
>>>>> Care to explain why? As your usage above shows, the module command is
>>>>> for
>>>>> adding or deleting modules. This functionality has nothing to do with
>>>>> that.
>>>>> --dontaudit is for specifying globally that dontaudit's should be turned
>>>>> on/off. It's not an option that modifies the behavior of adding or
>>>>> deleting
>>>>> a module, it's a completely separate thing.
>>>>>
>>>> No I don't care to explain why, now that you shot down my idea. :^)
>>>>
>>>> I guess it should be a separate command
>>>>
>>>> What do you think of.
>>>>
>>>> semanage dontaudit -a
>>>> semanage dontaudit -d
>>>>
>>>
>>> I like it being a separate command since it really is a global thing but
>>> the syntax above seems very confusing. Can we depart from the add/remove
>>> paradigm for this one and use something more appropriate, like on/off,
>>> enable/disable, audit/dontaudit, or something similar?
>>>
>>>
>>> -- 
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>> with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>
>>>
>>
>> semanage dontaudit on
>> semanage dontaudit off
> 
> Sounds great to me.
> 
> Chad
> 
How about this patch.

--------------070106080907020203070105
Content-Type: text/plain;
 name="policycoreutils-dontaudit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-dontaudit.patch"

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index c4c957c..2285489 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -54,6 +54,7 @@ semanage fcontext -{a|d|m} [-frst] file_spec
 semanage translation -{a|d|m} [-T] level
 semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean | boolean_file
 semanage permissive -{d|a} type
+semanage dontaudit [ on | off ]
 
 Primary Options:
 
@@ -116,6 +117,7 @@ Object-specific Options (see above):
 		valid_option["node"] += valid_everyone + [ '-M', '--mask', '-t', '--type', '-r', '--range', '-p', '--protocol']
 		valid_option["fcontext"] = []
 		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
+		valid_option["dontaudit"] = [ '-S', '--store' ]
 		valid_option["translation"] = []
 		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
 		valid_option["boolean"] = []
@@ -346,6 +348,12 @@ Object-specific Options (see above):
                         
                 target = cmds[0]
 
+
+		if object == "dontaudit":
+			OBJECT = seobject.dontauditClass(store)
+                        OBJECT.toggle(target)
+                        return
+                              
 		if add:
 			if object == "login":
 				OBJECT.add(target, seuser, serange)
diff --git a/policycoreutils/semanage/semanage.8 b/policycoreutils/semanage/semanage.8
index d0726cf..d83e94e 100644
--- a/policycoreutils/semanage/semanage.8
+++ b/policycoreutils/semanage/semanage.8
@@ -21,6 +21,8 @@ semanage \- SELinux Policy Management tool
 .br
 .B semanage permissive \-{a|d} type
 .br
+.B semanage dontaudit [ on | off ]
+.br
 .B semanage translation \-{a|d|m} [\-T] level
 .P
 
@@ -117,6 +119,8 @@ $ semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
 $ semanage port -a -t http_port_t -p tcp 81
 # Change apache to a permissive domain
 $ semanage permissive -a httpd_t
+# Turn off dontaudit rules
+$ semanage dontaudit off
 .fi
 
 .SH "AUTHOR"
diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 20bd205..9c5d2ec 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -314,6 +314,18 @@ class semanageRecords:
                self.transaction = False
                self.commit()
 
+class dontauditClass(semanageRecords):
+	def __init__(self, store):
+               semanageRecords.__init__(self, store)
+
+	def toggle(self, dontaudit):
+               if dontaudit not in [ "on", "off" ]:
+                      raise ValueError(_("dontaudit requires either 'on' or 'off'"))
+               self.begin()
+               rc = semanage_set_disable_dontaudit(self.sh, dontaudit == "on")
+               self.commit()
+               rc = semanage_reload_policy(self.sh)
+               
 class permissiveRecords(semanageRecords):
 	def __init__(self, store):
                semanageRecords.__init__(self, store)

--------------070106080907020203070105--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
