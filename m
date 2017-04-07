MIME-Version: 1.0
From: Nick Kralevich <nnk@google.com>
Date: Fri, 7 Apr 2017 11:39:55 -0700
Message-ID: <CAFJ0LnFHgkGSY73LwKNUbn+r+E6+TivuSkZq851y12ZvQ85Qbw@mail.gmail.com>
Subject: MLS directory label inheritance rules
To: SELinux <Selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a file is created in a directory, the default label for the file
is based on the label of the enclosing directory (unless something
like setfscreatecon is used). For example:

bullhead:/ # cd /data/misc/zoneinfo/

bullhead:/data/misc/zoneinfo # ls -ladZ .
drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
1971-06-19 17:07 .
bullhead:/data/misc/zoneinfo # touch asdf
bullhead:/data/misc/zoneinfo # ls -ladZ . asdf

drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
2017-04-07 18:32 .
-rw-rw-rw- 1 root   root   u:object_r:zoneinfo_data_file:s0    0
2017-04-07 18:32 asdf

note how the label of the "asdf" file matches the label of the
enclosing directory.

However, that's not true when the directory uses categories. In that
case, the newly created file inherits the label, but not the
categories. For example:

bullhead:/data/data # cd /data/data/com.android.chrome
bullhead:/data/data/com.android.chrome # ls -ladZ .
drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768 4096
1971-07-15 15:31 .
bullhead:/data/data/com.android.chrome # touch asdf
bullhead:/data/data/com.android.chrome # ls -laZd . asdf
drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768 4096
2017-04-07 18:35 .
-rw-rw-rw- 1 root   root   u:object_r:app_data_file:s0              0
2017-04-07 18:35 asdf

Note how the label is maintained, but the "c512,c768" portion is not
maintained. While this example occurs when I'm running in a permissive
domain, it also occurs in an enforcing domain.

The inconsistency seems weird, and I'm sure there's a good reason why
this occurs that I'm not familiar with. Can someone help me understand
if this is expected, and if so, why?

-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
