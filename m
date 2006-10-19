Message-ID: <45377C88.1040907@redhat.com>
Date: Thu, 19 Oct 2006 09:24:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Klaus Weidner <klaus@atsec.com>, Michael C Thompson <thompsmc@us.ibm.com>,
        lspp-list <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy issues in 2.3.18-10 - sshd & polyinstantiation
References: <453546FC.2050109@us.ibm.com> <20061017221211.GO28520@w-m-p.com>	 <453770BF.1090500@redhat.com> <1161262305.14632.89.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161262305.14632.89.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-10-19 at 08:34 -0400, Daniel J Walsh wrote:
>   
>> Klaus Weidner wrote:
>>     
>>> On Tue, Oct 17, 2006 at 04:11:24PM -0500, Michael C Thompson wrote:
>>>   
>>>       
>>>> So polyinstantiation is broken, it used to work at one point. The 
>>>> following is the log of what seems to be causing the failure. I'm 
>>>> looking into this, but it would be nice to have someone more adept at 
>>>> policy wrangling to jump in and save the day.
>>>>     
>>>>         
>>> The current LSPP ks script sets up policy and contexts to support
>>> polyinstantiation. I've attached the policy, here's the script fragment.
>>> Polyinstantiation parent dirs need to be polyparent_t, and
>>> /etc/security/namespace.init needs to be pam_exec_t or something similar.
>>>
>>> (Don't use chcon, define persistent file contexts instead to ensure that
>>> they don't get overwritten on the next autorelabel. And remember how nice
>>> it is that SELinux doesn't do path based security ;-)
>>>
>>> -Klaus
>>>
>>> ConfigurePolyinstantiation() {
>>>
>>>     Title " Configure polyinstantiation"
>>>
>>>     if ShallI "Update polyinstantiation (pam_namespace) configuration"; then
>>>         local DIRS=$(
>>>                 awk '/^[^#]/ {print $2}' $_BASE/$_NAMESPACE_CONF 
>>>         )
>>>         Log "Creating base dirs: $DIRS"
>>>         mkdir -m 0 $DIRS
>>>
>>>         local D
>>>         for D in $DIRS; do
>>>                 semanage fcontext -a -t polyparent_t $( echo "$D" | sed '
>>>                         s/\/$//;
>>>                         s/\([.*?]\)/\\\1/;
>>>                 ')
>>>         done
>>>         restorecon $DIRS
>>>
>>>         # FIXME: following should be fixed in upstream package?
>>>         semanage fcontext -a -t pam_exec_t /etc/security/namespace.init
>>>         restorecon /etc/security/namespace.init
>>>
>>>         Replace /etc/security/$_NAMESPACE_CONF with $_BASE/$_NAMESPACE_CONF
>>>
>>>     else
>>>         Log "configuration update declined."
>>>         _FAILURE=1
>>>     fi
>>> }
>>>
>>>   
>>> ------------------------------------------------------------------------
>>>
>>> ## Customized SELinux policy for LSPP evaluated configuration
>>>
>>> policy_module(lspp_policy,1.0)
>>>
>>> #############################################################################
>>> ### Additional audit
>>> #############################################################################
>>>
>>> gen_require(`
>>> 	attribute domain;
>>> ')
>>>
>>> # Audit setting of security relevant process attributes
>>> # These settings are OPTIONAL
>>> auditallow domain self:process setcurrent;
>>> auditallow domain self:process setexec;
>>> auditallow domain self:process setfscreate;
>>>   
>>>       
>> This gives every process on the system the ability to do these 
>> commands.  Why do you need this?
>>     
>
> No - they are just auditallow statements, not allow statements, so they
> merely enable auditing when they are allowed - they don't allow anything
> new.  This is for auditing of all changes to the process
> security-relevant attributes.
>
>   
Sorry, you are right.  I guess I am looking at too many lines of policy...
>>> #auditallow domain self:process setsocketcreate; # FIXME
>>> #auditallow domain self:process setipccreate; # FIXME
>>>
>>> #############################################################################
>>> ### Relabeling printer devices
>>> #############################################################################
>>>
>>> gen_require(`
>>> 	type secadm_t, printer_device_t;
>>> ')
>>>
>>> allow secadm_t printer_device_t:chr_file {getattr relabelfrom relabelto};
>>>
>>>   
>>>       
>> I have just added
>>         dev_relabel_all_dev_nodes(secadm_t)
>> in selinux-policy-2.3.19-4.
>>
>> Which should cover this.
>>
>>     
>>> #############################################################################
>>> ### Polyinstantiation support
>>> #############################################################################
>>>
>>> gen_require(`
>>>         type newrole_t, sshd_t, local_login_t;
>>> 	type user_t, staff_t;
>>> 	type tmp_t, user_home_dir_t, staff_home_dir_t;
>>> 	type user_tmp_t, staff_tmp_t, user_home_t, staff_home_t;
>>> 	attribute userdomain;
>>> ')
>>>
>>> type polyparent_t;
>>> type polymember_t;
>>> files_poly_parent(polyparent_t)
>>> files_poly_member(polymember_t)
>>>
>>>   
>>>       
>> There is a new boolean allow_polyinstantiation, which should turn on 
>> some of this support.
>> If we are missing something, this should get back into the policy package.
>>     
>>> ## FIXME: these don't work?
>>> #allow userdomain polyparent_t:dir manage_dir_perms;
>>> #allow userdomain polymember_t:dir manage_dir_perms;
>>> #type_member userdomain polyparent_t:dir polymember_t;
>>> #allow user_t polymember_t:dir manage_dir_perms;
>>> #allow staff_t polymember_t:dir manage_dir_perms;
>>>
>>> files_poly(tmp_t)
>>> files_poly(user_home_dir_t)
>>> files_poly(staff_home_dir_t)
>>>
>>> type_member user_t tmp_t:dir user_tmp_t;
>>> type_member staff_t tmp_t:dir staff_tmp_t;
>>>
>>> type_member user_t user_home_dir_t:dir user_home_t;
>>> type_member staff_t staff_home_dir_t:dir staff_home_t;
>>>
>>> files_polyinstantiate_all(sshd_t)
>>> files_polyinstantiate_all(local_login_t)
>>> files_polyinstantiate_all(newrole_t)
>>>   
>>>       
>> Only newole_t does not have this priv in current policy,   Added for 
>> 2.3.19-4.
>>     
>>> ### additional polyinst workarounds
>>> ### (FIXME, should these be fixed in refpolicy?)
>>>
>>> gen_require(`
>>> 	type bin_t, sshd_t, newrole_t, staff_su_t, run_init_t;
>>> ')
>>>
>>> # let newrole execute the PAM framework (it didn't d<o that originally)
>>> auth_exec_pam(newrole_t)
>>>
>>> # sshd needs to write the faillog / tallylog file
>>> # FIXME, needs: semanage fcontext -a -t faillog_t /var/log/tallylog
>>> auth_rw_faillog(sshd_t)
>>> auth_rw_faillog(newrole_t)
>>> auth_rw_faillog(staff_su_t)
>>> auth_rw_faillog(run_init_t)
>>>   
>>>       
>> Latest policy has these rules
>>     
>>> # this seems to be missing from refpolicy files_polyinstantiate_all()?
>>> allow sshd_t polyparent_t:dir {read search create remove_name};
>>> allow local_login_t polyparent_t:dir {read search create remove_name};
>>> allow newrole_t polyparent_t:dir {read search create remove_name};
>>>
>>> # need to be able to execute /etc/security/namespace.init
>>> # (that file needs to be labeled as bin_t, default label is bad)
>>> allow sshd_t bin_t:file {read execute execute_no_trans ioctl};
>>> allow local_login_t bin_t:file {read execute execute_no_trans ioctl};
>>> allow newrole_t bin_t:file {read execute execute_no_trans ioctl};
>>>
>>>   
>>>       
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>     


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
