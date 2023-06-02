Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BD8C7EE2C
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjFBMOl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjFBMOk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 08:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2724F1AE
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685708031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2Utrn7pgrDUV2gVvQu8IjbFxklQhlTFo5Ayt00/xkE=;
        b=WX3HOnaUF3P2BRrgP/U9dUmZAf9mDH2b5whe7MqvomhOcWZySFC0yaGJko3ynb9Mz/6EAW
        jkJxHU5/87IWGse6ESo07du3h4nJ/qV267sbpcVZ6UPYSK0qU3lgUJEyk9NM1g0BTbyaAE
        KdsCJvMCzg1YdqJKjlQlP6sOF7MZraw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-dTx12PmNOeaVzbRwT4DN9w-1; Fri, 02 Jun 2023 08:13:49 -0400
X-MC-Unique: dTx12PmNOeaVzbRwT4DN9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E96B3C02B6A;
        Fri,  2 Jun 2023 12:13:49 +0000 (UTC)
Received: from localhost (unknown [10.45.224.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE279E63;
        Fri,  2 Jun 2023 12:13:49 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH PR#394] semanage: list all ports even if not attributed
 with port_type
In-Reply-To: <20230530174929.10325-1-toiwoton@gmail.com>
References: <20230530174929.10325-1-toiwoton@gmail.com>
Date:   Fri, 02 Jun 2023 14:13:48 +0200
Message-ID: <87leh2jc3n.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> writes:

> Show also ports which are not attributed with `port_type`. Such ports
> may exist in custom policies and even the attribute `port_type` may
> not be defined.
>
> This fixes the following error:
>
> Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 975, in <module>
>     do_parser()
>   File "/usr/sbin/semanage", line 947, in do_parser
>     args.func(args)
>   File "/usr/sbin/semanage", line 441, in handlePort
>     OBJECT =3D object_dict['port'](args)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/seobject.py", line 1057, in __init=
__
>     self.valid_types =3D list(list(sepolicy.info(sepolicy.ATTRIBUTE, "por=
t_type"))[0]["types"])
>                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~^^^
> IndexError: list index out of range
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  python/semanage/seobject.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index d82da494..72a2ec55 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1055,7 +1055,7 @@ class portRecords(semanageRecords):
>      def __init__(self, args =3D None):
>          semanageRecords.__init__(self, args)
>          try:
> -            self.valid_types =3D list(list(sepolicy.info(sepolicy.ATTRIB=
UTE, "port_type"))[0]["types"])
> +            self.valid_types =3D list(list(sepolicy.info(sepolicy.PORT))=
[0]["type"])

I think it's a good approach. But the change seems to produce wrong results:

$ python
>>> import sepolicy
>>> list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
['afs3_callback_port_t', 'afs_bos_port_t', 'afs_fs_port_t', 'afs_ka_port_t'=
, 'afs_pt_port_t', 'afs_vl_port_t', 'agentx_port_t', 'amanda_port_t', 'amav=
isd_recv_port_t', 'amavisd_send_port_t', 'amqp_port_t', 'aol_port_t', 'apc_=
port_t', 'apcupsd_port_t', 'apertus_ldp_port_t', 'appswitch_emp_port_t', 'a=
sterisk_port_t', 'audit_port_t', 'auth_port_t', 'babel_port_t', 'bacula_por=
t_t', 'bctp_port_t', 'bfd_control_port_t', 'bfd_echo_port_t', 'bfd_multi_po=
rt_t', 'bgp_port_t', 'biff_port_t', 'boinc_client_port_t', 'boinc_port_t', =
'brlp_port_t', 'certmaster_port_t', 'chronyd_port_t', 'clamd_port_t', 'cloc=
kspeed_port_t', 'cluster_port_t', 'cma_port_t', 'cmadmin_port_t', 'cobbler_=
port_t', 'collectd_port_t', 'commplex_link_port_t', 'commplex_main_port_t',=
 'comsat_port_t', 'condor_port_t', 'conman_port_t', 'connlcli_port_t', 'con=
ntrackd_port_t', 'couchdb_port_t', 'ctdb_port_t', 'cvs_port_t', 'cyphesis_p=
ort_t', 'cyrus_imapd_port_t', 'daap_port_t', 'dbskkd_port_t', 'dcc_port_t',=
 'dccm_port_t', 'dey_keyneg_port_t', 'dey_sapi_port_t', 'dhcpc_port_t', 'dh=
cpd_port_t', 'dict_port_t', 'distccd_port_t', 'dns_port_t', 'dnssec_port_t'=
, 'dogtag_port_t', 'echo_port_t', 'efs_port_t', 'embrace_dp_c_port_t', 'eph=
emeral_port_t', 'epmap_port_t', 'epmd_port_t', 'fac_restore_port_t', 'finge=
rd_port_t', 'firepower_port_t', 'flash_port_t', 'fmpro_internal_port_t', 'f=
reeipmi_port_t', 'ftp_data_port_t', 'ftp_port_t', 'gatekeeper_port_t', 'gdo=
map_port_t', 'gds_db_port_t', 'gear_port_t', 'geneve_port_t', 'giftd_port_t=
', 'git_port_t', 'glance_port_t', 'glance_registry_port_t', 'gluster_port_t=
', 'gopher_port_t', 'gpsd_port_t', 'hadoop_datanode_port_t', 'hadoop_nameno=
de_port_t', 'hddtemp_port_t', 'hi_reserved_port_t', 'howl_port_t', 'hplip_p=
ort_t', 'http_cache_port_t', 'http_port_t', 'i18n_input_port_t', 'ibm_dt_2_=
port_t', 'imaze_port_t', 'inetd_child_port_t', 'innd_port_t', 'intermapper_=
port_t', 'interwise_port_t', 'ionixnetmon_port_t', 'ipmi_port_t', 'ipp_port=
_t', 'ipsecnat_port_t', 'ircd_port_t', 'isakmp_port_t', 'iscsi_port_t', 'is=
ns_port_t', 'jabber_client_port_t', 'jabber_interserver_port_t', 'jabber_ro=
uter_port_t', 'jacorb_port_t', 'jboss_debug_port_t', 'jboss_management_port=
_t', 'jboss_messaging_port_t', 'journal_remote_port_t', 'kerberos_admin_por=
t_t', 'kerberos_password_port_t', 'kerberos_port_t', 'keystone_port_t', 'kp=
rop_port_t', 'ktalkd_port_t', 'kubernetes_port_t', 'l2tp_port_t', 'ldap_por=
t_t', 'lirc_port_t', 'llmnr_port_t', 'lltng_port_t', 'lmtp_port_t', 'lrrd_p=
ort_t', 'lsm_plugin_port_t', 'luci_port_t', 'mail_port_t', 'mailbox_port_t'=
, 'matahari_port_t', 'memcache_port_t', 'milter_port_t', 'mmcc_port_t', 'mo=
ngod_port_t', 'monopd_port_t', 'mountd_port_t', 'movaz_ssc_port_t', 'mpd_po=
rt_t', 'ms_streaming_port_t', 'msnp_port_t', 'mssql_port_t', 'munin_port_t'=
, 'mxi_port_t', 'mysqld_port_t', 'mysqlmanagerd_port_t', 'mythtv_port_t', '=
nessus_port_t', 'netport_port_t', 'netsupport_port_t', 'neutron_port_t', 'n=
fs_port_t', 'nmbd_port_t', 'nmea_port_t', 'nodejs_debug_port_t', 'nsca_port=
_t', 'nsd_control_port_t', 'ntop_port_t', 'ntp_port_t', 'ntske_port_t', 'oa=
_system_port_t', 'ocsp_port_t', 'opendnssec_port_t', 'openflow_port_t', 'op=
enhpid_port_t', 'openqa_liveview_port_t', 'openqa_port_t', 'openqa_websocke=
ts_port_t', 'openvpn_port_t', 'openvswitch_port_t', 'oracle_port_t', 'osapi=
_compute_port_t', 'ovsdb_port_t', 'pdps_port_t', 'pegasus_http_port_t', 'pe=
gasus_https_port_t', 'pgpkeyserver_port_t', 'pingd_port_t', 'pki_ca_port_t'=
, 'pki_kra_port_t', 'pki_ocsp_port_t', 'pki_ra_port_t', 'pki_tks_port_t', '=
pki_tps_port_t', 'pktcable_cops_port_t', 'pop_port_t', 'port_t', 'portmap_p=
ort_t', 'postfix_policyd_port_t', 'postgresql_port_t', 'postgrey_port_t', '=
pptp_port_t', 'prelude_port_t', 'presence_port_t', 'preupgrade_port_t', 'pr=
inter_port_t', 'priority_e_com_port_t', 'prosody_port_t', 'ptal_port_t', 'p=
tp_event_port_t', 'pulp_port_t', 'pulseaudio_port_t', 'puppet_port_t', 'pxe=
_port_t', 'pyzor_port_t', 'qpasa_agent_port_t', 'rabbitmq_port_t', 'radacct=
_port_t', 'radius_port_t', 'radsec_port_t', 'razor_port_t', 'redis_port_t',=
 'repository_port_t', 'reserved_port_t', 'ricci_modcluster_port_t', 'ricci_=
port_t', 'rkt_port_t', 'rlogin_port_t', 'rlogind_port_t', 'rndc_port_t', 'r=
outer_port_t', 'rsh_port_t', 'rsync_port_t', 'rtp_media_port_t', 'rtsclient=
_port_t', 'rtsp_port_t', 'rwho_port_t', 'salt_port_t', 'sap_port_t', 'sapho=
stctrl_port_t', 'servistaitsm_port_t', 'sge_port_t', 'shellinaboxd_port_t',=
 'sieve_port_t', 'sip_port_t', 'sixxsconfig_port_t', 'smbd_port_t', 'smntub=
ootstrap_port_t', 'smtp_port_t', 'snmp_port_t', 'socks_port_t', 'soundd_por=
t_t', 'spamd_port_t', 'speech_port_t', 'squid_port_t', 'ssdp_port_t', 'ssh_=
port_t', 'statsd_port_t', 'stunnel_port_t', 'svn_port_t', 'svrloc_port_t', =
'swat_port_t', 'swift_port_t', 'sype_transport_port_t', 'syslog_tls_port_t'=
, 'syslogd_port_t', 'tangd_port_t', 'tcs_port_t', 'telnetd_port_t', 'tftp_p=
ort_t', 'time_port_t', 'tor_port_t', 'traceroute_port_t', 'tram_port_t', 't=
ransproxy_port_t', 'trisoap_port_t', 'trivnet1_port_t', 'unreserved_port_t'=
, 'ups_port_t', 'us_cli_port_t', 'utcpserver_port_t', 'uucpd_port_t', 'varn=
ishd_port_t', 'versa_tek_port_t', 'virt_migration_port_t', 'virt_port_t', '=
virtual_places_port_t', 'vnc_port_t', 'vqp_port_t', 'wap_wsp_port_t', 'wccp=
_port_t', 'websm_port_t', 'whois_port_t', 'winshadow_port_t', 'wsdapi_port_=
t', 'wsicopy_port_t', 'xdmcp_port_t', 'xen_port_t', 'xfs_port_t', 'xinuexpa=
nsion3_port_t', 'xinuexpansion4_port_t', 'xmsg_port_t', 'xodbc_connect_port=
_t', 'xserver_port_t', 'zabbix_agent_port_t', 'zabbix_port_t', 'zarafa_port=
_t', 'zebra_port_t', 'zented_port_t', 'zookeeper_client_port_t', 'zookeeper=
_election_port_t', 'zookeeper_leader_port_t', 'zope_port_t', 'container_por=
t_t', 'openshift_port_t', 'pasta_port_t', 'systemd_socket_proxyd_port_t', '=
test_port_t']

>>> list(list(sepolicy.info(sepolicy.PORT))[0]["type"])
['i', 'n', 'e', 't', 'd', '_', 'c', 'h', 'i', 'l', 'd', '_', 'p', 'o', 'r',=
 't', '_', 't']


Something like the following code could work:

>>> [x["type"] for x in list(list(sepolicy.info(sepolicy.PORT)))]


>          except RuntimeError:
>              pass
>=20=20
> --=20
> 2.39.2

