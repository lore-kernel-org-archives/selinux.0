Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3NK1xDC008249
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 16:01:59 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n3NK1xnD017254
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 20:01:59 GMT
Date: Thu, 23 Apr 2009 16:01:57 -0400
Subject: Re: patch to policycoreutils
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C6164175.A6B07%csellers@tresys.com>
In-Reply-To: <49EFC978.2010903@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/22/09 9:50 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> On 04/22/2009 06:03 PM, Chad Sellers wrote:
>> On 4/1/09 10:10 AM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>> 
>>> Multiple patches to policycoreutils.
>>> 
>>> First added /root/.ssh and /root/.ssh/*  to allow people to place keys
>>> in /root directory and have them labeled by restorcond
>>> 
>>> Fix transaction handling in semanage so you can update multiple records
>>> simultaniously.
>>> 
>>> Clean up permissive domains creation in semanage so it does not leave
>>> crap in /var/lib/selinux
>>> 
>>> diff --exclude-from=exclude --exclude=sepolgen-1.0.16 --exclude=gui
>>> --exclude=po -N -u -r nsapolicycoreutils/restorecond/restorecond.conf
>>> policycoreutils-2.0.62/restorecond/restorecond.conf
>>> --- nsapolicycoreutils/restorecond/restorecond.conf    2009-02-18
>>> 16:44:47.000000000 -0500
>>> +++ policycoreutils-2.0.62/restorecond/restorecond.conf    2009-02-23
>>> 11:32:21.000000000 -0500
>>> @@ -5,3 +5,7 @@
>>>   /var/run/utmp
>>>   /var/log/wtmp
>>>   ~/*
>>> +/root/.ssh
>>> +/root/.ssh/*
>>> +
>>> +
>>> diff --exclude-from=exclude --exclude=sepolgen-1.0.16 --exclude=gui
>>> --exclude=po -N -u -r nsapolicycoreutils/scripts/fixfiles
>>> policycoreutils-2.0.62/scripts/fixfiles
>>> --- nsapolicycoreutils/scripts/fixfiles    2009-02-18 16:44:47.000000000
>>> -0500
>>> +++ policycoreutils-2.0.62/scripts/fixfiles    2009-02-19 10:07:49.000000000
>>> -0500
>>> @@ -122,7 +122,7 @@
>>>   fi
>>>   if [ ! -z "$RPMFILES" ]; then
>>>       for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
>>> -    rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -i -f - 2>&1>>
>>> $LOGFILE
>>> +    rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -R -i -f -
>>> 2>&1>>
>>> $LOGFILE
>>>       done
>>>       exit $?
>>>   fi
>> Not sure I understand this one, and it didn't seem to be mentioned in your
>> comment. You're changing fixfiles to relabel recursively when it's fixing
>> files from an rpm? Wouldn't an rpm already list all the files it owned?
>> 
>> <snip due to previously ack'd patch>
>>> @@ -303,6 +308,12 @@
>>>                  if rc<  0:
>>>                         raise ValueError(_("Could not commit semanage
>>> transaction"))
>>> 
>>> +        def finish(self):
>>> +               if not self.transaction:
>>> +                      raise ValueError(_("Semanage transaction not in
>>> progress"))
>>> +               self.transaction = False
>>> +               self.commit()
>>> +
>>>   class permissiveRecords(semanageRecords):
>>>       def __init__(self, store):
>>>                  semanageRecords.__init__(self, store)
>>> @@ -328,6 +339,7 @@
>>> 
>>> 
>>>       def add(self, type):
>>> +               import glob
>>>                  name = "permissive_%s" % type
>>>                  dirname = "/var/lib/selinux"
>>>                  os.chdir(dirname)
>>> @@ -351,16 +363,19 @@
>>>                  fd.close()
>>> 
>>>                  rc = semanage_module_install(self.sh, data, len(data));
>>> -               if rc<  0:
>>> -            raise ValueError(_("Could not set permissive domain %s (module
>>> installation failed)") % name)
>>> -
>>> -               self.commit()
>>> +               if rc>= 0:
>>> +                      self.commit()
>>> 
>>>                  for root, dirs, files in os.walk("tmp", topdown=False):
>>>                         for name in files:
>>>                                os.remove(os.path.join(root, name))
>>>                         for name in dirs:
>>>                                os.rmdir(os.path.join(root, name))
>>> +               os.removedirs("tmp")
>>> +               for i in glob.glob("permissive_%s.*" % type):
>>> +                      os.remove(i)
>>> +               if rc<  0:
>>> +            raise ValueError(_("Could not set permissive domain %s (module
>>> installation failed)") % name)
>>> 
>>>       def delete(self, name):
>>>                  for n in name.split():
>> 
>> Other than that one thing, this looks fine to me.
>> 
>> Thanks,
>> Chad
>> 
>> 
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
> If a package owned a directory like /var/lib/libvirt/images, when it is
> relabeling we would want it to relabel not only the directory but the
> contents of the directory

Makes sense.

Acked-by: Chad Sellers <csellers@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
