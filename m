Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71B0C43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D912053B
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 14:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X8KA4vb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfLSOtW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:49:22 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34954 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfLSOtV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 09:49:21 -0500
Received: by mail-vs1-f67.google.com with SMTP id x123so3926043vsc.2
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2019 06:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XHoPhSktX/fV9MXsc1ES3JqCaLl9AJGmYjslauhZlP0=;
        b=X8KA4vb6/AmwZTiClb2iQPf7rGDA2UZTl+A7lLdTUhU7j+KS0lWh28V+y7wRYJR7/x
         iQIcZkoKedxdGiXe8r7ctLAKFRROb7QMivTIaftMDkCrv7y5KuwrffSFPnbGA2uIVjPX
         0Qu5RnDDQmNKyWt7ng0qBVeDpqDxuZsYN1/HwvU7PidImUMecaEI5Htgn+MhWHQ9Mn78
         91mzF2jWL1FXUX783UOQmprO5sXdSQovNBrM4pP/dpfXEKfwENX9PKwo4tuXsAjrO61Y
         gdIV9RdqBXeK1orhLqUV4Wqmz0+52oUPJZ4P1RyCgf0sP2FKHzFb8xiU0BqIIMrP2aPd
         M3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XHoPhSktX/fV9MXsc1ES3JqCaLl9AJGmYjslauhZlP0=;
        b=VzPzx/E3p2LWK0Cv+31ms2LiR9jCXerfzUliVAR5J2dRH5nbpNyj/t9zo9wtvFOCSv
         A2KxtKTSOU/UR2A3c9vimmuiz9/aoT8AbMRBDhm6mHno+t1RuNWkCF8TOg+uUQW6OGYw
         5bcRF4ffhUEnUaDzvPayIaP5j+VK1oVz+YipZklrL5uttgueqlvO6WlPrH7uQvuBWrEv
         1uHHKT8PWI8ZvzHPHsebuaothcRjq6xsqhpI/FCo+zcp6x8LhxHYED6ZiZKJB/MUcX2C
         s5QU2i4iLAPRJBaQ6/kG67AxvJ2erjsqff6JAz5ZYiyapOJ8XPJJKixtQGLQ4QDYksYp
         K4gQ==
X-Gm-Message-State: APjAAAWqvERiHUFv/8VTWNn9CnNf/G2TBhPkTm9P2nnsc+GSrYyWtg+j
        dKodhQpzqtQMPKL25Tgnknf3+esydXjCMG3ucsHz59sWQxQ=
X-Google-Smtp-Source: APXvYqzZA9/JQKSgwlK44AmxvnEQ1Q/PaptXuzOTneNKrkZfIWEOvPWX39wSGc04DtTu14tAfvJ12fUA7djPtKAzv5c=
X-Received: by 2002:a05:6102:5d1:: with SMTP id v17mr4971325vsf.200.1576766960231;
 Thu, 19 Dec 2019 06:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20191218142808.30433-1-cgzones@googlemail.com>
 <20191218142808.30433-5-cgzones@googlemail.com> <5dcd2838-33c5-db8a-5d85-e268fa2e0e89@tycho.nsa.gov>
In-Reply-To: <5dcd2838-33c5-db8a-5d85-e268fa2e0e89@tycho.nsa.gov>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 19 Dec 2019 15:49:09 +0100
Message-ID: <CAJ2a_DcwmdPLe=CfaAEtw-4utTeM3ayegfj+K1-dacnX1A2EWA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] core: add missing SELinux checks for dbus methods
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Mi., 18. Dez. 2019 um 21:05 Uhr schrieb Stephen Smalley <sds@tycho.nsa.g=
ov>:
>
> On 12/18/19 9:28 AM, Christian G=C3=B6ttsche wrote:
> > Add new SELinux permissions `modify` and `listdynusers` to the class `s=
ervice`.
> >    - modfiy checks altering operations, like `systemctl log-level debug=
` or `systemctl add-wants foo bar`.
> >    - listdynusers checks obtaining dynamic users, which is very common =
on systems using nss-systemd.
> >      Add a new permission to avoid undermining the `status` permission.
> >
> > Perform SELinux access checks for the following D-Bus exposed methods:
> >
> >    D-Bus interface         | c function name                    | SELin=
ux permission verb
> >
> >    GetAfter / GetBefore    | bus_job_method_get_waiting_jobs    | statu=
s
> >    LogTarget               | property_set_log_target            | modif=
y
> >    LogLevel                | property_set_log_level             | modif=
y
> >    RuntimeWatchdocUSec     | property_set_runtime_watchdog      | modif=
y
> >    ServiceWatchdogs        | bus_property_set_bool_wrapper      | modif=
y
> >    GetUnit                 | method_get_unit                    | statu=
s
> >    GetUnitByPID            | method_get_unit_by_pid             | statu=
s
> >    GetUnitByControlGroup   | method_get_unit_by_control_group   | statu=
s
> >    LoadUnit                | method_load_unit                   | statu=
s
> >    ListUnitsByNames        | method_list_units_by_names         | statu=
s
> >    LookupDynamicUserByName | method_lookup_dynamic_user_by_name | listd=
ynusers
> >    LookupDynamicUserByUID  | method_lookup_dynamic_user_by_uid  | listd=
ynusers
> >    GetDynamicUsers         | method_get_dynamic_users           | listd=
ynusers
> >    AddDependencyUnitFiles  | method_add_dependency_unit_files   | modif=
y
> >    GetUnitFileLinks        | method_get_unit_file_links         | statu=
s
> >    Unref                   | bus_unit_method_unref              | modif=
y
>
> If we are going to introduce new permissions or change existing ones, we
> may want to consider just defining a separate permission for every
> logical interface.  Then we can let the policy writer decide what
> matters to them and at what granularity they want to distinguish things,
> using macros/interfaces as appropriate to avoid needing to specify them
> all individually.
>
> Also, you may want to leverage the policy capability mechanism in
> userspace to permit compatible evolution of permission checks in the
> same manner it is presently used in the kernel for
> extended_socket_class, network_peer_controls, open_perms,
> nnp_nosuid_transition, etc.
>

This might be an idea, to preserve full backward compatibility.
While on it one could untangle the system security class.

Afaik this would require a SELinux userland and kernel update, to
introduce a new policy capability identifier?

>
> > ---
> >   src/core/dbus-job.c     |  4 ++
> >   src/core/dbus-manager.c | 89 ++++++++++++++++++++++++++++++++++++----=
-
> >   src/core/dbus-unit.c    |  4 ++
> >   3 files changed, 88 insertions(+), 9 deletions(-)
> >
> > diff --git a/src/core/dbus-job.c b/src/core/dbus-job.c
> > index a7d342257b..7b0b093757 100644
> > --- a/src/core/dbus-job.c
> > +++ b/src/core/dbus-job.c
> > @@ -71,6 +71,10 @@ int bus_job_method_get_waiting_jobs(sd_bus_message *=
message, void *userdata, sd_
> >           Job *j =3D userdata;
> >           int r, i, n;
> >
> > +        r =3D mac_selinux_unit_access_check(j->unit, message, "status"=
, error);
> > +        if (r < 0)
> > +                return r;
> > +
> >           if (strstr(sd_bus_message_get_member(message), "After"))
> >                   n =3D job_get_after(j, &list);
> >           else
> > diff --git a/src/core/dbus-manager.c b/src/core/dbus-manager.c
> > index c751e84253..d2db6e4a61 100644
> > --- a/src/core/dbus-manager.c
> > +++ b/src/core/dbus-manager.c
> > @@ -121,6 +121,10 @@ static int property_set_log_target(
> >           assert(bus);
> >           assert(value);
> >
> > +        r =3D mac_selinux_access_check(value, "modify", error);
> > +        if (r < 0)
> > +                return r;
> > +
> >           r =3D sd_bus_message_read(value, "s", &t);
> >           if (r < 0)
> >                   return r;
> > @@ -178,6 +182,10 @@ static int property_set_log_level(
> >           assert(bus);
> >           assert(value);
> >
> > +        r =3D mac_selinux_access_check(value, "modify", error);
> > +        if (r < 0)
> > +                return r;
> > +
> >           r =3D sd_bus_message_read(value, "s", &t);
> >           if (r < 0)
> >                   return r;
> > @@ -282,6 +290,10 @@ static int property_set_runtime_watchdog(
> >
> >           assert_cc(sizeof(usec_t) =3D=3D sizeof(uint64_t));
> >
> > +        r =3D mac_selinux_access_check(value, "modify", error);
> > +        if (r < 0)
> > +                return r;
> > +
> >           r =3D sd_bus_message_read(value, "t", t);
> >           if (r < 0)
> >                   return r;
> > @@ -289,6 +301,24 @@ static int property_set_runtime_watchdog(
> >           return watchdog_set_timeout(t);
> >   }
> >
> > +static int bus_property_set_bool_wrapper(
> > +                sd_bus *bus,
> > +                const char *path,
> > +                const char *interface,
> > +                const char *property,
> > +                sd_bus_message *value,
> > +                void *userdata,
> > +                sd_bus_error *error) {
> > +
> > +        int r;
> > +
> > +        r =3D mac_selinux_access_check(value, "modify", error);
> > +        if (r < 0)
> > +                return r;
> > +
> > +        return bus_property_set_bool(bus, path, interface, property, v=
alue, userdata, error);
> > +}
> > +
> >   static int bus_get_unit_by_name(Manager *m, sd_bus_message *message, =
const char *name, Unit **ret_unit, sd_bus_error *error) {
> >           Unit *u;
> >           int r;
> > @@ -375,6 +405,10 @@ static int method_get_unit(sd_bus_message *message=
, void *userdata, sd_bus_error
> >           if (r < 0)
> >                   return r;
> >
> > +        r =3D mac_selinux_unit_access_check(u, message, "status", erro=
r);
> > +        if (r < 0)
> > +                return r;
> > +
> >           return reply_unit_path(u, message, error);
> >   }
> >
> > @@ -413,6 +447,10 @@ static int method_get_unit_by_pid(sd_bus_message *=
message, void *userdata, sd_bu
> >           if (!u)
> >                   return sd_bus_error_setf(error, BUS_ERROR_NO_UNIT_FOR=
_PID, "PID "PID_FMT" does not belong to any loaded unit.", pid);
> >
> > +        r =3D mac_selinux_unit_access_check(u, message, "status", erro=
r);
> > +        if (r < 0)
> > +                return r;
> > +
> >           return reply_unit_path(u, message, error);
> >   }
> >
> > @@ -488,6 +526,10 @@ static int method_get_unit_by_control_group(sd_bus=
_message *message, void *userd
> >           if (!u)
> >                   return sd_bus_error_setf(error, BUS_ERROR_NO_SUCH_UNI=
T, "Control group '%s' is not valid or not managed by this instance", cgrou=
p);
> >
> > +        r =3D mac_selinux_unit_access_check(u, message, "status", erro=
r);
> > +        if (r < 0)
> > +                return r;
> > +
> >           return reply_unit_path(u, message, error);
> >   }
> >
> > @@ -510,6 +552,10 @@ static int method_load_unit(sd_bus_message *messag=
e, void *userdata, sd_bus_erro
> >           if (r < 0)
> >                   return r;
> >
> > +        r =3D mac_selinux_unit_access_check(u, message, "status", erro=
r);
> > +        if (r < 0)
> > +                return r;
> > +
> >           return reply_unit_path(u, message, error);
> >   }
> >
> > @@ -529,6 +575,7 @@ static int method_start_unit_generic(sd_bus_message=
 *message, Manager *m, JobTyp
> >           if (r < 0)
> >                   return r;
> >
> > +        /* bus_unit_method_start_generic() includes a mac_selinux chec=
k */
> >           return bus_unit_method_start_generic(message, u, job_type, re=
load_if_possible, error);
> >   }
> >
> > @@ -703,6 +750,10 @@ static int method_list_units_by_names(sd_bus_messa=
ge *message, void *userdata, s
> >           assert(message);
> >           assert(m);
> >
> > +        r =3D mac_selinux_access_check(message, "status", error);
> > +        if (r < 0)
> > +                return r;
> > +
> >           r =3D sd_bus_message_read_strv(message, &units);
> >           if (r < 0)
> >                   return r;
> > @@ -1263,11 +1314,11 @@ static int method_reload(sd_bus_message *messag=
e, void *userdata, sd_bus_error *
> >           assert(message);
> >           assert(m);
> >
> > -        r =3D verify_run_space("Refusing to reload", error);
> > +        r =3D mac_selinux_access_check(message, "reload", error);
> >           if (r < 0)
> >                   return r;
> >
> > -        r =3D mac_selinux_access_check(message, "reload", error);
> > +        r =3D verify_run_space("Refusing to reload", error);
> >           if (r < 0)
> >                   return r;
> >
> > @@ -1299,11 +1350,11 @@ static int method_reexecute(sd_bus_message *mes=
sage, void *userdata, sd_bus_erro
> >           assert(message);
> >           assert(m);
> >
> > -        r =3D verify_run_space("Refusing to reexecute", error);
> > +        r =3D mac_selinux_access_check(message, "reload", error);
> >           if (r < 0)
> >                   return r;
> >
> > -        r =3D mac_selinux_access_check(message, "reload", error);
> > +        r =3D verify_run_space("Refusing to reexecute", error);
> >           if (r < 0)
> >                   return r;
> >
> > @@ -1428,6 +1479,10 @@ static int method_switch_root(sd_bus_message *me=
ssage, void *userdata, sd_bus_er
> >           assert(message);
> >           assert(m);
> >
> > +        r =3D mac_selinux_access_check(message, "reboot", error);
> > +        if (r < 0)
> > +                return r;
> > +
> >           if (statvfs("/run/systemd", &svfs) < 0)
> >                   return sd_bus_error_set_errnof(error, errno, "Failed =
to statvfs(/run/systemd): %m");
> >
> > @@ -1441,10 +1496,6 @@ static int method_switch_root(sd_bus_message *me=
ssage, void *userdata, sd_bus_er
> >                               format_bytes(fb_need, sizeof(fb_need), RE=
LOAD_DISK_SPACE_MIN));
> >           }
> >
> > -        r =3D mac_selinux_access_check(message, "reboot", error);
> > -        if (r < 0)
> > -                return r;
> > -
> >           if (!MANAGER_IS_SYSTEM(m))
> >                   return sd_bus_error_setf(error, SD_BUS_ERROR_NOT_SUPP=
ORTED, "Root switching is only supported by system manager.");
> >
> > @@ -1636,6 +1687,10 @@ static int method_lookup_dynamic_user_by_name(sd=
_bus_message *message, void *use
> >           assert(message);
> >           assert(m);
> >
> > +        r =3D mac_selinux_access_check(message, "listdynusers", error)=
;
> > +        if (r < 0)
> > +                return r;
> > +
> >           r =3D sd_bus_message_read_basic(message, 's', &name);
> >           if (r < 0)
> >                   return r;
> > @@ -1663,6 +1718,10 @@ static int method_lookup_dynamic_user_by_uid(sd_=
bus_message *message, void *user
> >           assert(message);
> >           assert(m);
> >
> > +        r =3D mac_selinux_access_check(message, "listdynusers", error)=
;
> > +        if (r < 0)
> > +                return r;
> > +
> >           assert_cc(sizeof(uid) =3D=3D sizeof(uint32_t));
> >           r =3D sd_bus_message_read_basic(message, 'u', &uid);
> >           if (r < 0)
> > @@ -1692,6 +1751,10 @@ static int method_get_dynamic_users(sd_bus_messa=
ge *message, void *userdata, sd_
> >           assert(message);
> >           assert(m);
> >
> > +        r =3D mac_selinux_access_check(message, "listdynusers", error)=
;
> > +        if (r < 0)
> > +                return r;
> > +
> >           assert_cc(sizeof(uid_t) =3D=3D sizeof(uint32_t));
> >
> >           if (!MANAGER_IS_SYSTEM(m))
> > @@ -2264,6 +2327,10 @@ static int method_add_dependency_unit_files(sd_b=
us_message *message, void *userd
> >           assert(message);
> >           assert(m);
> >
> > +        r =3D mac_selinux_access_check(message, "modify", error);
> > +        if (r < 0)
> > +                return r;
> > +
> >           r =3D bus_verify_manage_unit_files_async(m, message, error);
> >           if (r < 0)
> >                   return r;
> > @@ -2300,6 +2367,10 @@ static int method_get_unit_file_links(sd_bus_mes=
sage *message, void *userdata, s
> >           char **p;
> >           int runtime, r;
> >
> > +        r =3D mac_selinux_access_check(message, "status", error);
> > +        if (r < 0)
> > +                return r;
> > +
> >           r =3D sd_bus_message_read(message, "sb", &name, &runtime);
> >           if (r < 0)
> >                   return r;
> > @@ -2422,7 +2493,7 @@ const sd_bus_vtable bus_manager_vtable[] =3D {
> >           /* The following item is an obsolete alias */
> >           SD_BUS_WRITABLE_PROPERTY("ShutdownWatchdogUSec", "t", bus_pro=
perty_get_usec, bus_property_set_usec, offsetof(Manager, reboot_watchdog), =
SD_BUS_VTABLE_HIDDEN),
> >           SD_BUS_WRITABLE_PROPERTY("KExecWatchdogUSec", "t", bus_proper=
ty_get_usec, bus_property_set_usec, offsetof(Manager, kexec_watchdog), 0),
> > -        SD_BUS_WRITABLE_PROPERTY("ServiceWatchdogs", "b", bus_property=
_get_bool, bus_property_set_bool, offsetof(Manager, service_watchdogs), 0),
> > +        SD_BUS_WRITABLE_PROPERTY("ServiceWatchdogs", "b", bus_property=
_get_bool, bus_property_set_bool_wrapper, offsetof(Manager, service_watchdo=
gs), 0),
> >           SD_BUS_PROPERTY("ControlGroup", "s", NULL, offsetof(Manager, =
cgroup_root), 0),
> >           SD_BUS_PROPERTY("SystemState", "s", property_get_system_state=
, 0, 0),
> >           SD_BUS_PROPERTY("ExitCode", "y", bus_property_get_unsigned, o=
ffsetof(Manager, return_value), 0),
> > diff --git a/src/core/dbus-unit.c b/src/core/dbus-unit.c
> > index 9477c47140..f86efaac3a 100644
> > --- a/src/core/dbus-unit.c
> > +++ b/src/core/dbus-unit.c
> > @@ -645,6 +645,10 @@ int bus_unit_method_unref(sd_bus_message *message,=
 void *userdata, sd_bus_error
> >           assert(message);
> >           assert(u);
> >
> > +        r =3D mac_selinux_unit_access_check(u, message, "modify", erro=
r);
> > +        if (r < 0)
> > +                return r;
> > +
> >           r =3D bus_unit_track_remove_sender(u, message);
> >           if (r =3D=3D -EUNATCH)
> >                   return sd_bus_error_setf(error, BUS_ERROR_NOT_REFEREN=
CED, "Unit has not been referenced yet.");
> >
>
