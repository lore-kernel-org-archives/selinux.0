Message-ID: <41DF02F2.5090503@redhat.com>
Date: Fri, 07 Jan 2005 16:45:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: There are several file_contexts that users might want to set in order
 to share data.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have added a configurable attribute (Need a better name).  So the 
policy writer could identify these files.

type httpd_sys_content_t, file_type,  httpdcontent, sysadmfile, 
configurable;
type httpd_sys_script_exec_t, file_type, sysadmfile, configurable;
type httpd_sys_script_ro_t, file_type, httpdcontent, sysadmfile, 
configurable;
type httpd_sys_script_rw_t, file_type, httpdcontent, sysadmfile, 
configurable;
type httpd_sys_script_ra_t, file_type, httpdcontent, sysadmfile, 
configurable;
type ftpd_anon_t, file_type, sysadmfile, configurable;
type samba_share_t, file_type, sysadmfile, configurable;

Then we could have something extract the fields out of policy and some 
how get this info to the users.
The question comes up since someone is starting to use samba to share 
files and they did not know what to set the data too.
The people documenting it would have no way of knowing without studying 
the policy. 

Ideas???

Maybe if we added this flag we could have setfiles/restorecon look at it 
and not change any files that have these context.  I know we already 
discussed this.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
