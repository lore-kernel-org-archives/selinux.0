Subject: Re: Running snmpd in a different domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bandan Das <bandan.das@stratus.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1239141949.17983.120.camel@BSD.mno.stratus.com>
References: <1239141949.17983.120.camel@BSD.mno.stratus.com>
Content-Type: text/plain
Date: Wed, 08 Apr 2009 08:43:52 -0400
Message-Id: <1239194632.3427.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-07 at 18:05 -0400, Bandan Das wrote:
> Hello,
> 
> On a RHEL5.3 system, I am trying to run snmpd in a different domain (not
> system_u:system_r:snmpd_t )if someone tries to run a specific init
> script I provide : i.e if someone executes /etc/init.d/ft-snmp, snmpd
> runs in system_u:system_r:ftsnmpd_t or else it runs in
> system_u:system_r:snmpd_t.
> 
> Does this make sense or I am missing something ?
> 
> To try this out, I thought of changing the file context
> of /etc/init.d/ft-snmp to system_u:object_r:ftsnmp_initrc_exec_t and
> then using domain_auto_trans() on it. My preliminary fc and te files are
> here :
> 
> [root@icefyres devel]# cat lsb-ft-snmp.te
> 
> policy_module(lsb-ft-snmp,2.1.0)
> 
> type ftsnmp_t;
> domain_type(ftsnmp_t)
> 
> type ftsnmp_exec_t;
> domain_entry_file(ftsnmp_t, ftsnmp_exec_t)
> 
> type ftsnmp_log_t;
> logging_log_file(ftsnmp_log_t)
> 
> type ftsnmp_tmp_t;
> files_tmp_file(ftsnmp_tmp_t)
> 
> type ftsnmp_initrc_exec_t;
> 
> [root@icefyres devel]# cat lsb-ft-snmp.fc
> 
> /opt/ft/sbin/ftlsubagent        --
> gen_context(system_u:object_r:ftsnmp_exec_t,s0)
> /opt/ft/sbin/ftltrapsubagent    --
> gen_context(system_u:object_r:ftsnmp_exec_t,s0)
> /etc/init.d/ft-snmp             --
> gen_context(system_u:object_r:ftsnmp_initrc_exec_t:s0)

Change the pathname regex to:
/etc/rc\.d/init\.d/ftp-snmp

(/etc/init.d is a symlink to /etc/rc.d/init.d, and "." is a regex
metacharacter)

> After loading lsb-ft-snmp.pp and relabeling the file system, I see that
> although, ftlsubagent and ftltrapsubagent have the intended contexts
> (system_u:object_r:ftsnmp_exec_t), /etc/init.d/ft-snmp's context is
> still system_u:object_r:initrc_exec_t and not
> system_u:object_r:ftsnmp_initrc_exec_t
> 
> Is this the correct way to change the context of the ft-snmp init
> script ?
>  
> 
> Thanks,
> Bandan
> 
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
