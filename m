Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7B2cxrT007734
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 22:38:59 -0400 (EDT)
Received: from smtp-09.primus.ca (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7B2cLET002318
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 02:38:23 GMT
Received: from dsl-207-112-23-123.tor.primus.ca ([207.112.23.123] helo=fugusec.net)
	by smtp-09.primus.ca with esmtp (Exim 3.36 #1)
	id 1BujBh-0005r2-0A
	for selinux@tycho.nsa.gov; Wed, 11 Aug 2004 02:50:01 +0000
Message-ID: <411986C1.3030601@fugusec.net>
Date: Tue, 10 Aug 2004 22:38:57 -0400
From: Alexis Wagner <venon@fugusec.net>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: network object
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I have some questions about selinux in a labeled network. 

First of all, I have read on the web that network labelling is not 
supported in kernel 2.6 an higher.  I have also read that it will be 
possible to reimplement the necessary features using the packet filter.
Is that true ?

Imagine I want to allow the domain one_t to set up and use  a tcp 
connection with the domain two_t on node two_t.  
Is it the correct way to set up the policy ?

node one  will have the following configuration :
net_contexts  :
        nodecon 10.10.10.2 255.255.255.255 system_u:object_r:node_two_t
one.te :
        allow one_t self:tcp_socket  { create_stream_socket_perms } ;
        allow one_t netif_type:netif  {tcp_recv tcp_send} ;
        allow one_t node_two_t:node {node_bind tcp_send tcp_recv};
        allow one_t port_t:tcp_socket {name_bind  recv_msg send_msg} ;
        allow one_t net_conf_t:file r_file_perms;

        allow one_t kernel_t:tcp_socket {recvfrom } ;
       #Wich domain I put here ? 
        allow one_t ???:tcp_socket {acceptfrom recvfrom } ;

node two will have the following configuration :
net_contexts  :
        nodecon 10.10.10.1 255.255.255.255 system_u:object_r:node_one_t
two.te :
        allow two_t self:tcp_socket  { create_stream_socket_perms } ;
        allow two_t netif_type:netif  {tcp_recv tcp_send} ;
        allow two_t node_one_t:node {node_bind tcp_send tcp_recv};
        allow two_t port_t:tcp_socket {name_bind  recv_msg send_msg} ;
        allow two_t net_conf_t:file r_file_perms;

        allow two_t kernel_t:tcp_socket {recvfrom } ;
       #Wich domain I put here ? 
        allow two_t ???:tcp_socket {acceptfrom recvfrom } ;


It is correct ?

Where could I find more uptodate information about using SELinux in a 
labeled network ?


Thank you,

Alexis Wagner



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
