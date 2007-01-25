Message-ID: <45B91E65.1010106@redhat.com>
Date: Thu, 25 Jan 2007 16:17:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [RFC] 0/4 - Hierarchal apache policy for reference policy
References: <6FE441CD9F0C0C479F2D88F959B015887B9E64@exchange.columbia.tresys.com> <45B0F7FA.1000506@mentalrootkit.com>
In-Reply-To: <45B0F7FA.1000506@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So how does this work.  I just added the following policy to create a 
httpd_squid_script_exec_t.

policy_module(squid_cgi,1.0.0)

apache_content_template(squid)
corenet_tcp_connect_http_cache_port(httpd_squid_script_t)
squid_read_config(httpd_squid_script_t)
allow httpd_squid_script_t self:tcp_socket create_socket_perms;
sysnet_read_config(httpd_squid_script_t)
corenet_non_ipsec_sendrecv(httpd_squid_script_t)

I take it the base apache policy did not have the right to read squid 
config data.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
