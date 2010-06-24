Message-ID: <4C237345.2010200@bian-fu.net>
Date: Thu, 24 Jun 2010 17:01:25 +0200
From: Alice Mynona <alice_mynona@bian-fu.net>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Developing a SELinux policy for antivirus - Activating a boolean
 variable when another has been actived
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

during the developing of a SELinux module I got the following error messages when executing "audit2allow -a -l"

...
libsepol.context_from_record: type antivirus_t is not defined
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert unconfined_u:unconfined_r:antivirus_t:s0 to sid

"antivirus_t" is a domain I have defined in my module:

type antivirus_t;
domain_type(antivirus_t)

I have already removed the module (semodule -r antivirus.pp && semodule -R) and did a file context repair afterwards (fixfiles restore). The error still exists. 

I have reinstalled the policy (yum reinstall selinux-policy-*), but the problem remains. I have also taken a look at "file_contexts" (cd /etc/selinux/targeted/modules/active && grep antivirus_t file_contexts*), but there's no "antivirus_t" anymore.

Can you help me to find the cause of the problem? I don't know how to debug libsepol-messages.

I'm using "selinux-policy-targeted-3.6.32-118.fc12.noarch".

Thanks in advance.

Best regards,
Alice

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
