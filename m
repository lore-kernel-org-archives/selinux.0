Message-ID: <45DDAA80.80603@redhat.com>
Date: Thu, 22 Feb 2007 09:36:48 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: I think this is equivalent to what we have now and more efficient.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

int is_selinux_enabled(void)
{
    security_context_t con;

    if (getcon_raw(&con) == 0) {
        int enabled = 1;
        if (!strcmp(con, "kernel"))
            enabled = 0;
        freecon(con);
        return enabled;
    } else {
        struct stat buf;
        return (stat("/proc/filesystems", &buf));
    }

}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
