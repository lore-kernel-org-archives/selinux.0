Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5O5AggA003380
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 01:10:42 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5O50nUD025893
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 05:00:49 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506231840.j5NIegqc030612@gotham.columbia.tresys.com>
References: <200506231840.j5NIegqc030612@gotham.columbia.tresys.com>
Content-Type: multipart/mixed; boundary="=-1DSyKeA6JanGAxZDEI1d"
Date: Fri, 24 Jun 2005 01:03:27 -0400
Message-Id: <1119589407.21978.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1DSyKeA6JanGAxZDEI1d
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Deleting specific lines from the file contexts file seems difficult and error
> prone while regenerating is straight forward. Only one code path (generation)
> instead of many (add, remove, change, etc).

You know... there is something good about regenerating things - it makes
sure the file is correct.

And my current way to add records to file is error prone - basically
I seek to the end of file, and add stuff there. That (1) doesn't
validate the rest of the file, and (2) is not atomic. I might
want to validate the rest of the file whether or not 
I think the errors are fatal (just to warn the user).

I've changed my modify_file function to do adds as well... 
The handler can now signal SIGADD to modify(), as well
as SIGDEL (and SIGOK/SIGERR/SIGEXIT/SIGMATCH). Then
there's a feedback record that the handler can pass
to be written. 

This:
- ensures atomicity (rename() call in the end)
- allows me to write records in the middle of the file if I please
- allows me to do validation (against policy), since the file 
might as well be checked while it's being parsed

Now I just need to figure out how to rollback handler side effects
(like loading users into the policy...)

Internal header attached.

To answer your question as to what's specific to the file backend - 
basically most of this... but not the record data structures.



--=-1DSyKeA6JanGAxZDEI1d
Content-Disposition: attachment; filename=records_file.h
Content-Type: text/x-chdr; name=records_file.h; charset=utf-8
Content-Transfer-Encoding: 7bit

#ifndef _SEPOL_RECORD_FILE_H_
#define _SEPOL_RECORD_FILE_H_

#ifndef RECORD_DEFINED
typedef void* record_t;
#define RECORD_DEFINED
#endif

#define RECORD_HANDLER_SIGOK 	0x00000001
#define RECORD_HANDLER_SIGERR	0x00000002
#define RECORD_HANDLER_SIGMATCH 0x00000004
#define RECORD_HANDLER_SIGDEL	0x00000008
#define RECORD_HANDLER_SIGADD   0x00000010
#define RECORD_HANDLER_SIGEXIT  0x00000020

typedef struct parse_info {
	unsigned int lineno;
	char* orig_line;
	char* working_copy;
	char* ptr;
	const char* filename;

	FILE* file_stream;
	FILE* copy_stream;

	void* parse_arg;
} parse_info_t;

typedef struct record_table {
	record_t (*create) (void);
	void (*destroy) (record_t record);
	int (*parse) (parse_info_t* info, record_t record);
	int (*print) (record_t record, FILE* str);
} record_table_t;

/*
 * Iterate over all records in the given file,
 * and invoke the handler with its given argument on each record.
 * The handler is supplied a record_t structure containing
 * the parsed data.
 */

int record_iterate_file(
	const char* filename,
	record_table_t* rtable,
	void* parse_arg,
	int (*handler) (
		record_t process_record, 
		record_t* feedback_record,
		void* arg), void* arg,
	int perr_fatal, int merr_fatal);
/*
 * Copy filename to filename.tmp, updating a particular record.
 * Invoke the handler, which may update the record, or issue a
 * delete signal. On failure, the tmp file is erased.
 * On success, the tmp file replaces the old file.
 */
int record_modify_file(
        const char* filename,
        record_table_t* rtable,
	void* parse_arg, 
	int (*handler) (
		record_t process_record, 
		record_t* feedback_record,
		void* arg), void* arg,
	int perr_fatal, int merr_fatal);

/*
 * Add a record to the config file (local) and to policy.
 * Please note that those functions are not atomic like
 * modify, and do not provide control over validation 
 */
int record_addto_file(
	const char* filename,
	record_table_t* rtable,
	record_t record);

int records_addto_file(
	const char* filename,
	record_table_t* rtable,
	record_t* records);

char* record_search_and_replace(const char* str,
	const char* substr, const char* replace);

char* record_filter_space_until(parse_info_t* info,
	const char* substr);

void record_dispose_line(parse_info_t* info);
int record_skip_space(parse_info_t* info);
char* record_fetch_string_inplace(parse_info_t* info);
int record_assert_noeof(parse_info_t* info);
int record_assert_space(parse_info_t* info);
int record_assert_ch(parse_info_t* info, const char ch);
int record_assert_str(parse_info_t* info, const char* assert_str);

#endif

--=-1DSyKeA6JanGAxZDEI1d--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
