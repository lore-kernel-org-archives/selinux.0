Message-ID: <72222DC86846D411ABD300A0C9EB08A101524483@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'sds@epoch.ncsc.mil'" <sds@epoch.ncsc.mil>
Subject: get_ordered_sid_list
Date: Tue, 3 Dec 2002 09:34:37 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In porting the Redhat 8.0 gdm I have a strange problem
in get_ordered_sid_list

login returns the correct number of sids 2.

root:sysadm_r:sysadm_t
root:user_r:user_t

login = "root"

 /* Get security context and SID for user */
  sidlistlen = SIDLISTLEN;   /* 10 */
  sidlist = malloc (sidlistlen*sizeof(security_id_t));
  if (sidlist == 0)
    {
      syslog (LOG_ERR, "SELinux gdm Login: no memory for SID list\n");
      return;
    }
  num_sids = get_ordered_sid_list (login, 0, sidlist, &sidlistlen);


the call returns 1 and the sid is
505   root:user_r:user_t

actual sids
504   root:sysadm_r:sysadm_t
505   root:user_r:user_t

Am I missing something obvious ?


Mark

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
