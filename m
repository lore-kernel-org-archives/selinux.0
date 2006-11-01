Subject: RE: SELinux Networking Enhancements
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: James Morris <jmorris@namei.org>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, jbrindle@tresys.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com, Paul Moore <paul.moore@hp.com>
In-Reply-To: <Pine.LNX.4.64.0610301237530.7342@d.namei>
References: <000001c6f779$515c8840$cc0a010a@tcssec.com>
	 <Pine.LNX.4.64.0610301237530.7342@d.namei>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 09:02:09 -0500
Message-Id: <1162389729.31675.157.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-30 at 13:27 -0500, James Morris wrote:
> # Server policy
> allow httpd_server_t httpd_client_t:peer { recv send };
> 
> # Client policy
> allow httpd_client_t httpd_server_t:peer { recv send };

Since we're talking about how policy, here is how I think the policy
should look like ideally, using the server side as example:

# service http requests (ipsec):
allow apache_t self:tcp_socket create_stream_socket_perms;
allow apache_t http_server_packet_t:packet { send recv };
allow apache_t http_spd_t:association polmatch;
allow apache_t mozilla_t:association { sendto recvfrom };
allow http_server_packet_t mozilla_t:association { flow_in flow_out };

# do dns lookups (non ipsec):
allow apache_t self:tcp_socket create_stream_socket_perms;
allow apache_t dns_client_packet_t:packet { send recv };
allow apache_t no_extlabel_t:association { sendto recvfrom };
allow dns_client_packet_t no_extlabel_t:association { flow_in flow_out };

This has the requirement that the type of the association is the same as
the type of the domain on the other side and no_extlabel_t (or
unlabeled_t) for unencrypted communications.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
