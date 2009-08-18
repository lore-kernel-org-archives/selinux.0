Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7ILZUEm032043
	for <selinux@tycho.nsa.gov>; Tue, 18 Aug 2009 17:35:30 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7ILabTk000557
	for <selinux@tycho.nsa.gov>; Tue, 18 Aug 2009 21:36:37 GMT
Message-ID: <4A8B1E9C.6060700@redhat.com>
Date: Tue, 18 Aug 2009 17:35:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to semanage
References: <C6AF47A4.A9CE7%csellers@tresys.com>
In-Reply-To: <C6AF47A4.A9CE7%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/17/2009 05:45 PM, Chad Sellers wrote:
> On 7/17/09 6:10 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> 
>> Ok lets try the patch again.
>>
>> Added equal patch (spelled correctly.)
>> Beginning to add modules support to consolidate on one management command.
>> Eventually replace semodule/setsebool with semanage command.
>> Some white space fixing in seobject.py
> 
> As I said previously, I've split this patch into the 3 separate patches
> (whitespace, equal, modules) for review purposes, as it was too difficult to
> get through with the 3 different patches interspersed. Please try to split
> up functional patches in the future.
> 
> This message will apply to the modules patch only.
> 
>> diff --git a/policycoreutils/semanage/semanage
>> b/policycoreutils/semanage/semanage
>> index 1688d85..072453d 100644
>> --- a/policycoreutils/semanage/semanage
>> +++ b/policycoreutils/semanage/semanage
>> @@ -44,7 +44,7 @@ if __name__ == '__main__':
>>                 text = _("""
>>  semanage [ -S store ] -i [ input_file | - ]
>>  
>> -semanage {boolean|login|user|port|interface|node|fcontext|translation} -{l|D}
>> [-n]
>> +semanage {module,boolean|login|user|port|interface|node|fcontext|translation}
>> -{l|D} [-n]
>>  semanage login -{a|d|m} [-sr] login_name | %groupname
>>  semanage user -{a|d|m} [-LrRP] selinux_name
>>  semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
>> @@ -53,7 +53,8 @@ semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask]
>> addr
>>  semanage fcontext -{a|d|m} [-frst] [-e path ] file_spec
>>  semanage translation -{a|d|m} [-T] level
>>  semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean | boolean_file
>> -semanage permissive -{d|a} type
>> +semanage permissive -{a|d} type
>> +semanage module -{a|d|} module
>>  
>>  Primary Options:
>>  
>> @@ -68,6 +69,7 @@ Primary Options:
>>      -h, --help       Display this message
>>      -n, --noheading  Do not print heading when listing OBJECTS
>>          -S, --store      Select and alternate SELinux store to manage
>> +        --dontaudit      Turn on or off dontaudit rules
>>  
> Need to specify that this takes an integer argument (1 or 0) here. Also,
> need to specify which command this is valid for, which appears to be the
> module command. Why is this an option for the module command? It doesn't
> seem to have anything to do with a particular module. Should this just be
> its own command?
> 
I think it should be just for the modules command.
>>  Object-specific Options (see above):
>>  
>> @@ -121,6 +123,8 @@ Object-specific Options (see above):
>>          valid_option["translation"] += valid_everyone + [ '-T', '--trans' ]
>>          valid_option["boolean"] = []
>>          valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1",
>> "-0", "-F", "--file"]
>> +        valid_option["module"] = []
>> +        valid_option["module"] += [ '-a', '--add', '-d', '--delete', '-l',
>> '--list', '-h', '--help', '-n', '--noheading', '--dontaudit']
>>          valid_option["permissive"] = []
>>          valid_option["permissive"] += [ '-a', '--add', '-d', '--delete',
>> '-l', '--list', '-h', '--help', '-n', '--noheading', '-D', '--deleteall' ]
>>          return valid_option
>> @@ -194,6 +198,7 @@ Object-specific Options (see above):
>>          use_file = False
>>                  store = ""
>>                  equal = ""
>> +                dontaudit = ""
>>          
>>          object = argv[0]
>>          option_dict=get_options()
>> @@ -207,6 +212,7 @@ Object-specific Options (see above):
>>                          ['add',
>>                           'delete',
>>                           'deleteall',
>> +                         'dontaudit=',
>>                           'equal=',
>>                           'ftype=',
>>                           'file',
>> @@ -259,6 +265,9 @@ Object-specific Options (see above):
>>              if o == "-F"  or o == "--file":
>>                  use_file = True
>>  
>> +            if o == "--dontaudit":
>> +                                dontaudit = not int(a)
>> +
>>              if o == "-h" or o == "--help":
>>                                 raise ValueError(_("%s bad option") % o)
>>  
>> @@ -331,6 +340,9 @@ Object-specific Options (see above):
>>          
>>          if object == "boolean":
>>              OBJECT = seobject.booleanRecords(store)
>> +
>> +        if object == "module":
>> +            OBJECT = seobject.moduleRecords(store)
>>          
>>          if object == "translation":
>>              OBJECT = seobject.setransRecords()
>> @@ -349,6 +361,13 @@ Object-specific Options (see above):
>>              OBJECT.deleteall()
>>                          return
>>              
>> +        if dontaudit != "":
>> +            if object == "module":
>> +                               OBJECT.dontaudit(dontaudit)
>> +                        else:
>> +                               raise ValueError(_("%s bad option") % o)
>> +                        return
>> +
>>          if len(cmds) != 1:
>>                         raise ValueError(_("%s bad option") % o)
>>                  
>> @@ -370,6 +389,9 @@ Object-specific Options (see above):
>>              if object == "interface":
>>                  OBJECT.add(target, serange, setype)
>>  
>> +            if object == "module":
>> +                OBJECT.add(target)
>> +
>>              if object == "node":
>>                  OBJECT.add(target, mask, proto, serange, setype)
>>  
>> @@ -397,6 +419,9 @@ Object-specific Options (see above):
>>                  rlist = roles.split()
>>                  OBJECT.modify(target, rlist, selevel, serange, prefix)
>>  
>> +            if object == "module":
>> +                OBJECT.modify(target)
>> +
>>              if object == "port":
>>                  OBJECT.modify(target, proto, serange, setype)
>>  
>> diff --git a/policycoreutils/semanage/semanage.8
>> b/policycoreutils/semanage/semanage.8
>> index 31e98c7..56208d8 100644
>> --- a/policycoreutils/semanage/semanage.8
>> +++ b/policycoreutils/semanage/semanage.8
>> @@ -21,6 +21,8 @@ semanage \- SELinux Policy Management tool
>>  .br
>>  .B semanage permissive \-{a|d} type
>>  .br
>> +.B semanage module \-{a|d} policy_package
>> +.br
>>  .B semanage translation \-{a|d|m} [\-T] level
>>  .P
>>  
>> diff --git a/policycoreutils/semanage/seobject.py
>> b/policycoreutils/semanage/seobject.py
>> index 94bdf7f..7f911a9 100644
>> --- a/policycoreutils/semanage/seobject.py
>> +++ b/policycoreutils/semanage/seobject.py
>> @@ -314,6 +314,49 @@ class semanageRecords:
>>                 self.transaction = False
>>                 self.commit()
>>  
>> +class moduleRecords(semanageRecords):
>> +    def __init__(self, store):
>> +               semanageRecords.__init__(self, store)
>> +
>> +    def get_all(self):
>> +               l = []
>> +               (rc, mlist, number) = semanage_module_list(self.sh)
>> +               if rc < 0:
>> +                      raise ValueError(_("Could not list SELinux modules"))
>> +
>> +               for i in range(number):
>> +                      mod = semanage_module_list_nth(mlist, i)
>> +                      name = semanage_module_get_name(mod)
>> +                      l.append(name)
>> +               return l
>> +
>> +    def dontaudit(self, dontaudit = 0):
>> +               self.begin()
>> +               rc = semanage_set_disable_dontaudit(self.sh, dontaudit)
>> +               self.commit()
>> +               rc = semanage_reload_policy(self.sh)
>> +
>> +    def list(self, heading = 1, locallist = 0):
>> +        if heading:
>> +            print "\n%-25s\n" % (_("Modules"))
>> +                for t in self.get_all():
>> +                       print t
>> +
>> +    def add(self, modules):
>> +               import glob
>> +               for m in modules.split():
>> +                      rc = semanage_module_install_file(self.sh, m);
>> +               if rc >= 0:
>> +                      self.commit()
>> +
> Why import glob here? It doesn't look like you use it.
> 
>> +    def delete(self, modules):
>> +               for m in modules.split():
>> +                      rc = semanage_module_remove(self.sh, m)
>> +                      if rc < 0:
>> +                             raise ValueError(_("Could not remove module %s
>> (remove failed)") % name)
>> +                
>> +               self.commit()
>> +            
>>  class permissiveRecords(semanageRecords):
>>      def __init__(self, store):
>>                 semanageRecords.__init__(self, store)
> 
> Other than that, I have no problem with the code in the patch. The bigger
> problem with this is that it's still incomplete at this point. There's still
> no support for:
> - base modules
> - build (without changing anything)
> - reload (without changing anything)
> - module version number in listing
> - install/upgrade distinction (though I'm perfectly fine with ditching this)
> 
> I'm not comfortable merging this before at least base modules are supported.
> Having an additional tool that doesn't meet the basic requirements for users
> will just lead to confusion.
> 
> Thanks,
> Chad
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 

Yes dontaudit should only be for the modules command.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
