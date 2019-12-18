Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB41C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 20:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3182176D
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 20:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="W6nXuRlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLRUFT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:05:19 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:19841 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfLRUFT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 15:05:19 -0500
X-EEMSG-check-017: 37280160|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="37280160"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 20:05:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576699516; x=1608235516;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=z/3gDO/MbHV68vdXW7XkRTmKk0RedKzIDNpN+3dD3Eo=;
  b=W6nXuRlBiuIMvfICSAFXUr7LXMSHwcceHbEWL43Lndsu5iZDA0CAOp6h
   yPlQ/T/rzG/RCBlYgCpAc5c6ItF7FR45v7775R1LLbp0J9hrRXqmp+DzE
   +JyPdTnhqZ7Z3rs1iNCg0AmNbwJ7FtIKX32or8Afi8i1/cSzhYR0JYhOx
   qQ2Ar6UNakqGuDTUn1jaq4T6cSTfhjqbTsPjTAxlhMEsmsaWaT+UDK8/O
   pxE5xz3Q0sZPpIrtyi0Pd2M8YY+MsKpkxKgDujL4kSuF+6/fCSfRKF7+L
   Gx5JgihZfxUdacPLNIbMIh3eoEGUD6Fh4WXomnO4RB+sDm4QCkn0mxpK+
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="31254109"
IronPort-PHdr: =?us-ascii?q?9a23=3AyGii3RPsB9Z92KiUFTEl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0IvvyrarrMEGX3/hxlliBBdydt6sfzbCO4uu5AzxIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQnNssQajpZuJrgyxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKjA28HvTisdtkqxVphyvrAF7z4LNYIyYMP9yc6XAdt0YWG?=
 =?us-ascii?q?VBRN5cWTFfDIOyb4UBDOQPMuhXoIb/u1QAogCzBRWvCe711jNEmnH70K883u?=
 =?us-ascii?q?88EQ/GxgsgH9cWvXrJsNX6Kr8SUeCrw6nO0D7NcvZW1i356IjMbB8goeyHUL?=
 =?us-ascii?q?VrccXM0kkiDB/Fj1WMpozlODOZzOINs3OB4OZ6WuKvjHAnphh3rzOyxckskp?=
 =?us-ascii?q?HEip8ax13L7yl0wJs5KcemREN0f9KoCoZcuieHPIVsWMwiWXtnuCMix70Dvp?=
 =?us-ascii?q?60YTYFxYw8xx7ad/yHa4+I4g//VOqJITd3mnZleLWnihau60eg0Oz8VtSv0F?=
 =?us-ascii?q?pQrypFlNfMtncW1xPN9seLUOd9/0e91jaP0ADf8OdELlwvlaXHMZIhx78wlp?=
 =?us-ascii?q?4LvUTCGC/5hln2gbeLekgr9eWk8eTqbqj8qpOCOIJ4lBvyPrk2lsy6G+s4Mw?=
 =?us-ascii?q?wOX2aB+eS70b3u5Vb5T6hRjvAtjqnYsIzVJcQcpqKjBQ9VyZws5wywDzehzt?=
 =?us-ascii?q?QUhWMHI05deBKbk4jpPEnDL+z3Dfa+hFSslilkx+vdM73uBZXNKXfDkLP/cr?=
 =?us-ascii?q?Z48UFcyQ4zwcpD6JJTD7ELOOjzVVPptNzEEh85NBS5w/35B9V514MeX3+PA6?=
 =?us-ascii?q?CCPaPMvl+H+PgvL/OPZIALojb9LeYq5/r0gX8+g18dcvrh4ZxCQ3CiH+96Ik?=
 =?us-ascii?q?yfVlVynssaGmcH9l41Q/7tjlCZeTFUYHm2Uqc15zV9A4WjW8OLXY2pgbqczA?=
 =?us-ascii?q?+lEZBMIGNLEFaBFTHvbYrXde0LbXepPsJ5kjECHYOkQosl2ADm4BT20JJ7P+?=
 =?us-ascii?q?HU/Wserpul299rsb6A3Sou/CB5WpzOm1qGSHt5yyZVFjI=3D?=
X-IPAS-Result: =?us-ascii?q?A2DrAAC+hfpd/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIFxBYFtIBKELokDhloGgTeJapFFCQEBAQEBAQEBATcBAYRAAoI9OBMCE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshUOCOymCewEFIwQLAQVRCxgCAiYCAlcGAQwIAQGCX?=
 =?us-ascii?q?z+CUyWuKX8zhU+DPIFBgQ4ojDJ5gQeBEScPgl0+h1mCXgSNHhqIdYEnd5Y+g?=
 =?us-ascii?q?j+CQ5NKBhuaTo5OnF8igVgrCAIYCCEPO4JtTxgNjR4XjkEjA49dAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2019 20:05:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIK4tEq132726;
        Wed, 18 Dec 2019 15:04:56 -0500
Subject: Re: [RFC PATCH 4/8] core: add missing SELinux checks for dbus methods
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20191218142808.30433-1-cgzones@googlemail.com>
 <20191218142808.30433-5-cgzones@googlemail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5dcd2838-33c5-db8a-5d85-e268fa2e0e89@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 15:05:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218142808.30433-5-cgzones@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/18/19 9:28 AM, Christian Göttsche wrote:
> Add new SELinux permissions `modify` and `listdynusers` to the class `service`.
>    - modfiy checks altering operations, like `systemctl log-level debug` or `systemctl add-wants foo bar`.
>    - listdynusers checks obtaining dynamic users, which is very common on systems using nss-systemd.
>      Add a new permission to avoid undermining the `status` permission.
> 
> Perform SELinux access checks for the following D-Bus exposed methods:
> 
>    D-Bus interface         | c function name                    | SELinux permission verb
> 
>    GetAfter / GetBefore    | bus_job_method_get_waiting_jobs    | status
>    LogTarget               | property_set_log_target            | modify
>    LogLevel                | property_set_log_level             | modify
>    RuntimeWatchdocUSec     | property_set_runtime_watchdog      | modify
>    ServiceWatchdogs        | bus_property_set_bool_wrapper      | modify
>    GetUnit                 | method_get_unit                    | status
>    GetUnitByPID            | method_get_unit_by_pid             | status
>    GetUnitByControlGroup   | method_get_unit_by_control_group   | status
>    LoadUnit                | method_load_unit                   | status
>    ListUnitsByNames        | method_list_units_by_names         | status
>    LookupDynamicUserByName | method_lookup_dynamic_user_by_name | listdynusers
>    LookupDynamicUserByUID  | method_lookup_dynamic_user_by_uid  | listdynusers
>    GetDynamicUsers         | method_get_dynamic_users           | listdynusers
>    AddDependencyUnitFiles  | method_add_dependency_unit_files   | modify
>    GetUnitFileLinks        | method_get_unit_file_links         | status
>    Unref                   | bus_unit_method_unref              | modify

If we are going to introduce new permissions or change existing ones, we 
may want to consider just defining a separate permission for every 
logical interface.  Then we can let the policy writer decide what 
matters to them and at what granularity they want to distinguish things, 
using macros/interfaces as appropriate to avoid needing to specify them 
all individually.

Also, you may want to leverage the policy capability mechanism in 
userspace to permit compatible evolution of permission checks in the 
same manner it is presently used in the kernel for 
extended_socket_class, network_peer_controls, open_perms, 
nnp_nosuid_transition, etc.

> ---
>   src/core/dbus-job.c     |  4 ++
>   src/core/dbus-manager.c | 89 ++++++++++++++++++++++++++++++++++++-----
>   src/core/dbus-unit.c    |  4 ++
>   3 files changed, 88 insertions(+), 9 deletions(-)
> 
> diff --git a/src/core/dbus-job.c b/src/core/dbus-job.c
> index a7d342257b..7b0b093757 100644
> --- a/src/core/dbus-job.c
> +++ b/src/core/dbus-job.c
> @@ -71,6 +71,10 @@ int bus_job_method_get_waiting_jobs(sd_bus_message *message, void *userdata, sd_
>           Job *j = userdata;
>           int r, i, n;
>   
> +        r = mac_selinux_unit_access_check(j->unit, message, "status", error);
> +        if (r < 0)
> +                return r;
> +
>           if (strstr(sd_bus_message_get_member(message), "After"))
>                   n = job_get_after(j, &list);
>           else
> diff --git a/src/core/dbus-manager.c b/src/core/dbus-manager.c
> index c751e84253..d2db6e4a61 100644
> --- a/src/core/dbus-manager.c
> +++ b/src/core/dbus-manager.c
> @@ -121,6 +121,10 @@ static int property_set_log_target(
>           assert(bus);
>           assert(value);
>   
> +        r = mac_selinux_access_check(value, "modify", error);
> +        if (r < 0)
> +                return r;
> +
>           r = sd_bus_message_read(value, "s", &t);
>           if (r < 0)
>                   return r;
> @@ -178,6 +182,10 @@ static int property_set_log_level(
>           assert(bus);
>           assert(value);
>   
> +        r = mac_selinux_access_check(value, "modify", error);
> +        if (r < 0)
> +                return r;
> +
>           r = sd_bus_message_read(value, "s", &t);
>           if (r < 0)
>                   return r;
> @@ -282,6 +290,10 @@ static int property_set_runtime_watchdog(
>   
>           assert_cc(sizeof(usec_t) == sizeof(uint64_t));
>   
> +        r = mac_selinux_access_check(value, "modify", error);
> +        if (r < 0)
> +                return r;
> +
>           r = sd_bus_message_read(value, "t", t);
>           if (r < 0)
>                   return r;
> @@ -289,6 +301,24 @@ static int property_set_runtime_watchdog(
>           return watchdog_set_timeout(t);
>   }
>   
> +static int bus_property_set_bool_wrapper(
> +                sd_bus *bus,
> +                const char *path,
> +                const char *interface,
> +                const char *property,
> +                sd_bus_message *value,
> +                void *userdata,
> +                sd_bus_error *error) {
> +
> +        int r;
> +
> +        r = mac_selinux_access_check(value, "modify", error);
> +        if (r < 0)
> +                return r;
> +
> +        return bus_property_set_bool(bus, path, interface, property, value, userdata, error);
> +}
> +
>   static int bus_get_unit_by_name(Manager *m, sd_bus_message *message, const char *name, Unit **ret_unit, sd_bus_error *error) {
>           Unit *u;
>           int r;
> @@ -375,6 +405,10 @@ static int method_get_unit(sd_bus_message *message, void *userdata, sd_bus_error
>           if (r < 0)
>                   return r;
>   
> +        r = mac_selinux_unit_access_check(u, message, "status", error);
> +        if (r < 0)
> +                return r;
> +
>           return reply_unit_path(u, message, error);
>   }
>   
> @@ -413,6 +447,10 @@ static int method_get_unit_by_pid(sd_bus_message *message, void *userdata, sd_bu
>           if (!u)
>                   return sd_bus_error_setf(error, BUS_ERROR_NO_UNIT_FOR_PID, "PID "PID_FMT" does not belong to any loaded unit.", pid);
>   
> +        r = mac_selinux_unit_access_check(u, message, "status", error);
> +        if (r < 0)
> +                return r;
> +
>           return reply_unit_path(u, message, error);
>   }
>   
> @@ -488,6 +526,10 @@ static int method_get_unit_by_control_group(sd_bus_message *message, void *userd
>           if (!u)
>                   return sd_bus_error_setf(error, BUS_ERROR_NO_SUCH_UNIT, "Control group '%s' is not valid or not managed by this instance", cgroup);
>   
> +        r = mac_selinux_unit_access_check(u, message, "status", error);
> +        if (r < 0)
> +                return r;
> +
>           return reply_unit_path(u, message, error);
>   }
>   
> @@ -510,6 +552,10 @@ static int method_load_unit(sd_bus_message *message, void *userdata, sd_bus_erro
>           if (r < 0)
>                   return r;
>   
> +        r = mac_selinux_unit_access_check(u, message, "status", error);
> +        if (r < 0)
> +                return r;
> +
>           return reply_unit_path(u, message, error);
>   }
>   
> @@ -529,6 +575,7 @@ static int method_start_unit_generic(sd_bus_message *message, Manager *m, JobTyp
>           if (r < 0)
>                   return r;
>   
> +        /* bus_unit_method_start_generic() includes a mac_selinux check */
>           return bus_unit_method_start_generic(message, u, job_type, reload_if_possible, error);
>   }
>   
> @@ -703,6 +750,10 @@ static int method_list_units_by_names(sd_bus_message *message, void *userdata, s
>           assert(message);
>           assert(m);
>   
> +        r = mac_selinux_access_check(message, "status", error);
> +        if (r < 0)
> +                return r;
> +
>           r = sd_bus_message_read_strv(message, &units);
>           if (r < 0)
>                   return r;
> @@ -1263,11 +1314,11 @@ static int method_reload(sd_bus_message *message, void *userdata, sd_bus_error *
>           assert(message);
>           assert(m);
>   
> -        r = verify_run_space("Refusing to reload", error);
> +        r = mac_selinux_access_check(message, "reload", error);
>           if (r < 0)
>                   return r;
>   
> -        r = mac_selinux_access_check(message, "reload", error);
> +        r = verify_run_space("Refusing to reload", error);
>           if (r < 0)
>                   return r;
>   
> @@ -1299,11 +1350,11 @@ static int method_reexecute(sd_bus_message *message, void *userdata, sd_bus_erro
>           assert(message);
>           assert(m);
>   
> -        r = verify_run_space("Refusing to reexecute", error);
> +        r = mac_selinux_access_check(message, "reload", error);
>           if (r < 0)
>                   return r;
>   
> -        r = mac_selinux_access_check(message, "reload", error);
> +        r = verify_run_space("Refusing to reexecute", error);
>           if (r < 0)
>                   return r;
>   
> @@ -1428,6 +1479,10 @@ static int method_switch_root(sd_bus_message *message, void *userdata, sd_bus_er
>           assert(message);
>           assert(m);
>   
> +        r = mac_selinux_access_check(message, "reboot", error);
> +        if (r < 0)
> +                return r;
> +
>           if (statvfs("/run/systemd", &svfs) < 0)
>                   return sd_bus_error_set_errnof(error, errno, "Failed to statvfs(/run/systemd): %m");
>   
> @@ -1441,10 +1496,6 @@ static int method_switch_root(sd_bus_message *message, void *userdata, sd_bus_er
>                               format_bytes(fb_need, sizeof(fb_need), RELOAD_DISK_SPACE_MIN));
>           }
>   
> -        r = mac_selinux_access_check(message, "reboot", error);
> -        if (r < 0)
> -                return r;
> -
>           if (!MANAGER_IS_SYSTEM(m))
>                   return sd_bus_error_setf(error, SD_BUS_ERROR_NOT_SUPPORTED, "Root switching is only supported by system manager.");
>   
> @@ -1636,6 +1687,10 @@ static int method_lookup_dynamic_user_by_name(sd_bus_message *message, void *use
>           assert(message);
>           assert(m);
>   
> +        r = mac_selinux_access_check(message, "listdynusers", error);
> +        if (r < 0)
> +                return r;
> +
>           r = sd_bus_message_read_basic(message, 's', &name);
>           if (r < 0)
>                   return r;
> @@ -1663,6 +1718,10 @@ static int method_lookup_dynamic_user_by_uid(sd_bus_message *message, void *user
>           assert(message);
>           assert(m);
>   
> +        r = mac_selinux_access_check(message, "listdynusers", error);
> +        if (r < 0)
> +                return r;
> +
>           assert_cc(sizeof(uid) == sizeof(uint32_t));
>           r = sd_bus_message_read_basic(message, 'u', &uid);
>           if (r < 0)
> @@ -1692,6 +1751,10 @@ static int method_get_dynamic_users(sd_bus_message *message, void *userdata, sd_
>           assert(message);
>           assert(m);
>   
> +        r = mac_selinux_access_check(message, "listdynusers", error);
> +        if (r < 0)
> +                return r;
> +
>           assert_cc(sizeof(uid_t) == sizeof(uint32_t));
>   
>           if (!MANAGER_IS_SYSTEM(m))
> @@ -2264,6 +2327,10 @@ static int method_add_dependency_unit_files(sd_bus_message *message, void *userd
>           assert(message);
>           assert(m);
>   
> +        r = mac_selinux_access_check(message, "modify", error);
> +        if (r < 0)
> +                return r;
> +
>           r = bus_verify_manage_unit_files_async(m, message, error);
>           if (r < 0)
>                   return r;
> @@ -2300,6 +2367,10 @@ static int method_get_unit_file_links(sd_bus_message *message, void *userdata, s
>           char **p;
>           int runtime, r;
>   
> +        r = mac_selinux_access_check(message, "status", error);
> +        if (r < 0)
> +                return r;
> +
>           r = sd_bus_message_read(message, "sb", &name, &runtime);
>           if (r < 0)
>                   return r;
> @@ -2422,7 +2493,7 @@ const sd_bus_vtable bus_manager_vtable[] = {
>           /* The following item is an obsolete alias */
>           SD_BUS_WRITABLE_PROPERTY("ShutdownWatchdogUSec", "t", bus_property_get_usec, bus_property_set_usec, offsetof(Manager, reboot_watchdog), SD_BUS_VTABLE_HIDDEN),
>           SD_BUS_WRITABLE_PROPERTY("KExecWatchdogUSec", "t", bus_property_get_usec, bus_property_set_usec, offsetof(Manager, kexec_watchdog), 0),
> -        SD_BUS_WRITABLE_PROPERTY("ServiceWatchdogs", "b", bus_property_get_bool, bus_property_set_bool, offsetof(Manager, service_watchdogs), 0),
> +        SD_BUS_WRITABLE_PROPERTY("ServiceWatchdogs", "b", bus_property_get_bool, bus_property_set_bool_wrapper, offsetof(Manager, service_watchdogs), 0),
>           SD_BUS_PROPERTY("ControlGroup", "s", NULL, offsetof(Manager, cgroup_root), 0),
>           SD_BUS_PROPERTY("SystemState", "s", property_get_system_state, 0, 0),
>           SD_BUS_PROPERTY("ExitCode", "y", bus_property_get_unsigned, offsetof(Manager, return_value), 0),
> diff --git a/src/core/dbus-unit.c b/src/core/dbus-unit.c
> index 9477c47140..f86efaac3a 100644
> --- a/src/core/dbus-unit.c
> +++ b/src/core/dbus-unit.c
> @@ -645,6 +645,10 @@ int bus_unit_method_unref(sd_bus_message *message, void *userdata, sd_bus_error
>           assert(message);
>           assert(u);
>   
> +        r = mac_selinux_unit_access_check(u, message, "modify", error);
> +        if (r < 0)
> +                return r;
> +
>           r = bus_unit_track_remove_sender(u, message);
>           if (r == -EUNATCH)
>                   return sd_bus_error_setf(error, BUS_ERROR_NOT_REFERENCED, "Unit has not been referenced yet.");
> 

