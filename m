Message-ID: <45DB3637.7080400@redhat.com>
Date: Tue, 20 Feb 2007 12:56:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: chcat changes (Was:  Re: policycoreutils patch)
References: <45DB0AB8.3070803@redhat.com> <1171988571.14363.111.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1171988571.14363.111.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-02-20 at 09:50 -0500, Daniel J Walsh wrote:
>   
>> chcat fixes:
>>     * Broken stderr handling fix
>>     * if serange ends in a ":" chop it off.
>>     * Switch chcat to exec semanage rather than use builtin so that 
>> proper transitions happen, otherwise I would have to run chcat under an 
>> semanage context.
>>     
>
> Why would a range end in a ":"?  Context translation issue?
>
>   
No.
      new_serange = "%s-%s:%s" % (serange[0], top[0], string.join(cats, 
","))
        if new_serange[-1:] == ":":
            new_serange = new_serange[:-1]
If you did not have cats you would end up with s0-s0:

>> diff --exclude-from=exclude --exclude=sepolgen-1.0.0 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/chcat policycoreutils-2.0.1/scripts/chcat
>> --- nsapolicycoreutils/scripts/chcat	2006-11-16 17:14:27.000000000 -0500
>> +++ policycoreutils-2.0.1/scripts/chcat	2007-02-15 15:16:09.000000000 -0500
>> @@ -25,11 +25,22 @@
>>  import commands, sys, os, pwd, string, getopt, selinux
>>  import seobject
>>  import gettext
>> +import codecs
>> +import locale
>> +sys.stderr = codecs.getwriter(locale.getpreferredencoding())(sys.__stderr__, 'replace')
>> +sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.__stdout__, 'replace')
>>  
>>  try:
>>      gettext.install('policycoreutils')
>> -except:
>> -    pass
>> +except IOError:
>> +       import __builtin__
>> +       __builtin__.__dict__['_'] = unicode
>> +
>> +def errorExit(error):
>> +    sys.stderr.write("%s: " % sys.argv[0])
>> +    sys.stderr.write("%s\n" % error)
>> +    sys.stderr.flush()
>> +    sys.exit(1)
>>  
>>  def verify_users(users):
>>      for u in users:
>> @@ -62,12 +73,20 @@
>>          for i in newcat[1:]:
>>              if i not in cats:
>>                  cats.append(i)
>> +
>>          new_serange = "%s-%s:%s" % (serange[0], top[0], string.join(cats, ","))
>> -        
>> +        if new_serange[-1:] == ":":
>> +            new_serange = new_serange[:-1]
>> +            
>>          if add_ind:
>> -            logins.add(u, user[0], new_serange)
>> +            cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
>>          else:
>> -            logins.modify(u, user[0], new_serange)
>> +            cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
>> +        rc = commands.getstatusoutput(cmd)
>> +        if rc[0] != 0:
>> +            print rc[1]
>> +            errors += 1
>> +
>>      return errors
>>          
>>  def chcat_add(orig, newcat, objects,login_ind):
>> @@ -133,11 +152,17 @@
>>                  cats.remove(i)
>>  
>>          new_serange = "%s-%s:%s" % (serange[0], top[0], string.join(cats, ","))
>> +        if new_serange[-1:] == ":":
>> +            new_serange = new_serange[:-1]
>>          
>>          if add_ind:
>> -            logins.add(u, user[0], new_serange)
>> +            cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
>>          else:
>> -            logins.modify(u, user[0], new_serange)
>> +            cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
>> +        rc = commands.getstatusoutput(cmd)
>> +        if rc[0] != 0:
>> +            print rc[1]
>> +            errors += 1
>>      return errors
>>          
>>  def chcat_remove(orig, newcat, objects, login_ind):
>> @@ -198,11 +223,17 @@
>>              user = seusers["__default__"]
>>          serange = user[1].split("-")
>>          new_serange = "%s-%s:%s" % (serange[0],newcat[0], string.join(newcat[1:], ","))
>> -        
>> +        if new_serange[-1:] == ":":
>> +            new_serange = new_serange[:-1]
>> +
>>          if add_ind:
>> -            logins.add(u, user[0], new_serange)
>> +            cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
>>          else:
>> -            logins.modify(u, user[0], new_serange)
>> +            cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
>> +        rc = commands.getstatusoutput(cmd)
>> +        if rc[0] != 0:
>> +            print rc[1]
>> +            errors += 1
>>      return errors
>>      
>>  def chcat_replace(newcat, objects, login_ind):
>> @@ -362,6 +393,10 @@
>>  
>>          if list_ind == 0 and len(cmds) < 1:
>>              usage()
>> +
>> +    except getopt.error, error:
>> +        errorExit(_("Options Error %s ") % error.msg)
>> +
>>      except ValueError, e:
>>          usage()
>>  
>> diff --exclude-from=exclude --exclude=sepolgen-1.0.0 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/chcat.8 policycoreutils-2.0.1/scripts/chcat.8
>> --- nsapolicycoreutils/scripts/chcat.8	2007-01-17 11:11:34.000000000 -0500
>> +++ policycoreutils-2.0.1/scripts/chcat.8	2007-02-15 15:16:09.000000000 -0500
>> @@ -3,30 +3,31 @@
>>  chcat \- change file SELinux security category
>>  .SH SYNOPSIS
>>  .B chcat
>> -\fICATEGORY FILE\fR...
>> +\fIcategory file\fR...
>>  .br
>>  .B chcat -l 
>> -\fICATEGORY USER\fR...
>> +\fIcategory user\fR...
>>  .br
>>  .B chcat
>> -\fI[[+|-]CATEGORY],...]  FILE\fR...
>> +\fI[[+|-]category...]  file\fR...
>>  .br
>>  .B chcat -l 
>> -\fI[[+|-]CATEGORY],...]  USER\fR...
>> +\fI[[+|-]category...]  user\fR...
>>  .br
>>  .B chcat
>> -[\fI-d\fR] \fIFILE\fR...
>> +[\fI-d\fR] \fIfile\fR...
>>  .br
>>  .B chcat -l 
>> -[\fI-d\fR] \fIUSER\fR...
>> +[\fI-d\fR] \fIuser\fR...
>>  .br
>>  .B chcat
>> -\fI-L\fR [-l] [ USER ... ] 
>> +\fI-L\fR [ -l ] [ user ... ] 
>>  .br
>> +.SH DESCRIPTION
>>  .PP
>> -Change/Remove the security CATEGORY for each FILE/USER.
>> +Change/Remove the security \fIcategory\fR for each \fIfile\fR or \fIuser\fR.
>>  .PP
>> -Use +/- to add/remove categories from a FILE/USER.
>> +Use +/- to add/remove categories from a \fIfile\fR or \fIuser\fR.
>>  .PP
>>  .B
>>  Note:
>>     
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
