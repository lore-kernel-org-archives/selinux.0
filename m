Message-ID: <40B53A27.9070709@nc.rr.com>
Date: Wed, 26 May 2004 20:45:27 -0400
From: Jeff Johnson <n3npq@nc.rr.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New design for policy on disk allowing multiple policy rpms to
 be simultaniously installed.
References: <40B394AF.2000801@redhat.com> <40B39C09.5040300@nc.rr.com> <1085590563.31854.95.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1085590563.31854.95.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2004-05-25 at 15:18, Jeff Johnson wrote:
>  
>
>>Well, the existing means to handle simultaneous installs of otherwise 
>>mutually exclusive packages is the
>>alternatives mechanism used to handle sendmail vs. postfix and lpd vs. cups.
>>
>>Yes, symlinks, feeble, but that is the existing mechanism, might as well 
>>use if in the distro.
>>    
>>
>
>Can you elaborate on how this works presently?  How do you avoid
>conflicts among multiple packages owning those symlinks?
>
>  
>

Sure.

sendmail and postfix are mutually conflicting because both wish to use 
/usr/lib/sendmail.

So the path is a symlink, conflicts avoided because the symlink is not part
of any package, but rather a side effect of the install:
$ rpm -qf /usr/lib/sendmail
file /usr/lib/sendmail is not owned by any package

See also "man alternatives".

Here are the scripts from the sendmail package, edited to remove "other 
stuff":

$ rpm -q --scripts sendmail

postinstall scriptlet (using /bin/sh):

#
# Set up the alternatives files for MTAs.
#
/usr/sbin/alternatives --install /usr/sbin/sendmail mta 
/usr/sbin/sendmail.sendmail 90 \
        --slave /usr/bin/mailq mta-mailq /usr/bin/mailq.sendmail \
        --slave /usr/bin/newaliases mta-newaliases 
/usr/bin/newaliases.sendmail \
        --slave /usr/bin/rmail mta-rmail /usr/bin/rmail.sendmail \
        --slave /usr/lib/sendmail mta-sendmail /usr/lib/sendmail.sendmail \
        --slave /etc/pam.d/smtp mta-pam /etc/pam.d/smtp.sendmail \
        --slave /usr/share/man/man8/sendmail.8.gz mta-sendmailman 
/usr/share/man/man8/sendmail.sendmail.8.gz \
        --slave /usr/share/man/man1/mailq.1.gz mta-mailqman 
/usr/share/man/man1/mailq.sendmail.1.gz \
        --slave /usr/share/man/man1/newaliases.1.gz mta-newaliasesman 
/usr/share/man/man1/newaliases.sendmail.1.gz \
        --slave /usr/share/man/man5/aliases.5.gz mta-aliasesman 
/usr/share/man/man5/aliases.sendmail.5.gz \
        --initscript sendmail
 
 

preuninstall scriptlet (using /bin/sh):
if [ $1 = 0 ]; then
        /usr/sbin/alternatives --remove mta /usr/sbin/sendmail.sendmail
fi
exit 0
postuninstall scriptlet (using /bin/sh):
if [ "$1" -ge "1" ]; then
        mta=`readlink /etc/alternatives/mta`
        if [ "$mta" == "/usr/sbin/sendmail.sendmail" ]; then
                /usr/sbin/alternatives --set mta /usr/sbin/sendmail.sendmail
        fi
fi
exit 0

HTH

73 de Jeff


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
