Message-ID: <456224F2.6010707@redhat.com>
Date: Mon, 20 Nov 2006 16:58:10 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C79BC@exchange.columbia.tresys.com> <455CE2F3.3070200@mentalrootkit.com> <455DA4E8.5050600@redhat.com> <4561E1A3.8070306@mentalrootkit.com> <4561E7B2.9030205@redhat.com> <4561F3EA.8020603@tresys.com>
In-Reply-To: <4561F3EA.8020603@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> audit2allow was not generating reference policy correctly.  This 
>> patches fixes this and uses /usr/share/sleinux/devel/Makefile to 
>> create policy packages.
>>
>
> This is distro specific, audit2allow should be using 
> /etc/selinux/config to find the interface directory to use. Further, 
> why is this needed at all?
>
audit2allow -R -M local -i /var/log/audit/audit.log 

Attempts to match interfaces against devel package, and build potential 
policies.  Without this change
audit2allow blows up.

Not sure what you want to extrace out of /etc/selinux/config?  The type 
of the policy? And then go to /usr/share/selinux/TYPE/include/Makefile?
> > run_init needs to call pam_acct_mgmt, so that pam_tally will work
> > correctly.
> >
>
> What is pam_tally and what does the call to pam_acct_mgmt do, and how 
> does it affect run_init?
>
I believe pam_tally increments a counter for failed logins in 
pam_authenticate and decrements it when it gets to pam_account 
management.  If it never gets there, the counter continues to increment.
> > Also after modifying translations the mcstrans needs to be signaled.
> >
> > (I think it is time we break the mcstrans code out into a separate
> > script, maybe executed by semanage, which would allow us to write
> > tighter policy around this object and semanage.)
>
> Its interesting that semanage manages something that is redhat 
> specific and not part of the upstream utilities at all.. IMO this 
> should never have been merged in the first place, semanage manages 
> libsemanage abstractions, if translations were a part of libsemanage 
> it'd be a different story.
>
Agreed, I think we should break it out and maybe allow semanage to have 
a plugin type interface, so the administrator still uses the same 
command to manage other parts of "SELinux" that do not come from upstream.
>> Lastly are you going to merge the translations?
>> http://people.redhat.com/dwalsh/SELinux/pocicycoreutils-po.patch
>>
>>
>
> It can be merged when a revised patchset does.
>
> p.s. please please inline patches and make them apply from the top of 
> the tree with -p1 or -p0 :)
>
We are applying these patches with a -p1? 
>> @@ -204,7 +206,8 @@
>>          os.write(fd, self.out())
>>          os.close(fd)
>>          os.rename(newfilename, self.filename)
>> -
>> +                os.system("/sbin/service mcstrans reload > /dev/null")
>> +                
>
> This is very distro specific and totally inappropriate IMO.
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
