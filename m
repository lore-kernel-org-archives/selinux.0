Message-ID: <4378D6F9.5070301@redhat.com>
Date: Mon, 14 Nov 2005 13:27:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: rawhide targeted vs. refpolicy rpm
References: <BF9A263D.7FFA%csellers@tresys.com>	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>	 <200511141041.49643.csellers@tresys.com> <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil> <4378B88B.6040003@redhat.com> <4378C285.3080005@tresys.com>
In-Reply-To: <4378C285.3080005@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> policycoreutils patch to genhomedircon to use libsemanage to read 
>> seusers file.
>>
>>
> <snip>
>>  
>>  class selinuxConfig:
>>      def __init__(self, selinuxdir="/etc/selinux", type="targeted", 
>> usepwd=1):
>> +        self.semanageHandle=semanage_handle_create()
>> +        self.semanaged=semanage_is_managed(self.semanageHandle)
>> +        if self.semanaged:
>> +            semanage_connect(self.semanageHandle)
>> +            (status, self.ulist, self.usize) = 
>> semanage_user_list(self.semanageHandle)
>>          self.type=type
>>          self.selinuxdir=selinuxdir +"/"
>>          self.contextdir="/contexts"
>> @@ -313,47 +142,72 @@
>>              errorExit(string.join("sed error ", rc[1]))
>>  
>>      def getUsersFile(self):
>> -        return self.selinuxdir+self.type+"/users/local.users"
>> +        if self.semanaged:
>> +            return self.selinuxdir+self.type+"module/active/seusers"
> Why should this return a path at all in the managed case? 
> genhomedircon (or any semanage user) can't make an assumption that a 
> particular path is used, accessible or even on the same computer.
Ok I guess we could throw an exception.
>
>> +        else:
>> +            return self.selinuxdir+self.type+"/seusers"
>>  
>> -    def getSystemUsersFile(self):
>> -        return self.selinuxdir+self.type+"/users/system.users"
>> -       
>>      def heading(self):
>>          ret = "\n#\n#\n# User-specific file contexts, generated via 
>> %s\n" % sys.argv[0]
>>          ret += "# edit %s to change file_context\n#\n#\n" % 
>> self.getUsersFile()
>>          return ret
>>  
>> +
>> +    def defaultrole(self, name):
>> +        for idx in range(self.usize):
>> +            user = semanage_user_by_idx(self.ulist, idx)
>> +            if semanage_user_get_name(user) == name:
>> +                role=semanage_user_get_defrole(user)
>> +                if role=="system_r":
>> +                    # targeted policy
>> +                    return "user_r"
> I don't understand this case. Why wouldn't user_get_defrole return 
> user_r in the targeted case?
>
user_r is not defined in targeted policy.  Everything runs in one role 
system_r.  Problem is we don't use system_home_t.
>> +                else:
>> +                    return  role
>> +        return name
>> +    def adduser(self, udict, user, seuser, role):
>> +        try:
>> +            if seuser == "user_u" or user == "__default__":
>> +                return
>> +            # !!! chooses first role in the list to use in the file 
>> context !!!
> or what semanage considers the default role, right?
>
>> +            if role[-2:] == "_r" or role[-2:] == "_u":
>> +                role = role[:-2]
>> +            home = pwd.getpwnam(user)[5]
>> +            if home == "/":
>> +                return
>> +            prefs = {}
>> +            prefs["role"] = role
>> +            prefs["home"] = home
>> +            udict[seuser] = prefs
>> +        except KeyError:
>> +            sys.stderr.write("The user \"%s\" is not present in the 
>> passwd file, skipping...\n" % user)
>> +
> <snip>
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
